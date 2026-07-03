//
//  ContentView.swift
//  ClassicConcerts
//
//  Created by Subin on 6/28/26.
//

import SwiftUI


struct ContentView: View {
    @State private var concerts: [Concert] = []
    @State private var loadState: LoadState = .idle
    @State private var searchText = ""

    @State private var fromDate = Date()
    @State private var toDate   = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    @State private var showDatePicker = false

    @State private var searchTask: Task<Void, Never>?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavHeader()
            NavDateSelectBar(fromDate: $fromDate, toDate: $toDate, showDatePicker: $showDatePicker)
            NavSearchBar(searchText: $searchText, onSearch: debounceSearch)
            countRow
            content
            Spacer(minLength: 0)
        }
        .background(Color.white.ignoresSafeArea())
        .task { await load() }
        .sheet(isPresented: $showDatePicker) {
            
            DatePickerSheet(fromDate: $fromDate, toDate: $toDate) {
                Task { await load() }
            }
        }
    }

    private var countRow: some View {
        Text("\(concerts.count) performances")
            .font(.system(size: 13, weight: .medium)).foregroundColor(.navySub)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 28).padding(.bottom, 12)
    }

    @ViewBuilder private var content: some View {
        switch loadState {
        case .idle, .loading:
            ProgressView().frame(maxWidth: .infinity).padding(.top, 40)
        case .failed(let msg):
            errorView(msg)
        case .loaded where concerts.isEmpty:
            Text("No performances found.")
                .font(.system(size: 14)).foregroundColor(.navySub)
                .frame(maxWidth: .infinity).padding(.top, 40)
        case .loaded:
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(concerts) { ConcertCard(concert: $0) }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    private func errorView(_ msg: String) -> some View {
        VStack(spacing: 12) {
            Text(msg).font(.system(size: 14)).foregroundColor(.navySub)
                .multilineTextAlignment(.center)
            Button("Try again") { Task { await load() } }
                .font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
                .padding(.horizontal, 20).padding(.vertical, 10)
                .background(Color.navy)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity).padding(.top, 40)
    }

    private func debounceSearch() {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            if Task.isCancelled { return }
            await load()
        }
    }
    
    // api 호출
    private func load() async {
        loadState = .loading
        do {
            concerts = try await ConcertService.shared.fetchClassicConcerts(
                startDate: Self.ymd(fromDate),
                endDate: Self.ymd(toDate),
                keyword: searchText)
            loadState = .loaded
        } catch {
            loadState = .failed(error.localizedDescription)
        }
    }
    static func date(_ s: String) -> Date {
        let f = DateFormatter(); f.dateFormat = "yyyy.MM.dd"
        return f.date(from: s) ?? Date()
    }
    static func string(_ d: Date) -> String { // UI표시용
        let f = DateFormatter(); f.dateFormat = "yyyy.MM.dd"; return f.string(from: d)
    }
    static func ymd(_ d: Date) -> String { // 서버 전송용
        let f = DateFormatter(); f.dateFormat = "yyyyMMdd"; return f.string(from: d)
    }
}



#Preview {
    ContentView()
}
