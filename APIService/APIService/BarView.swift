//
//  BarView.swift
//  APIService
//
//  Created by Subin on 7/3/26.
//

import SwiftUI

struct NavHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("CLASSICAL")
                .font(.system(size: 11, weight: .semibold)).tracking(2.5)
                .foregroundColor(.gold)
            Text("Concerts")
                .font(.custom("PlayfairDisplay-Bold", size: 36))
                .foregroundColor(.navy)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 28).padding(.vertical, 14)
    }
}

struct NavDateSelectBar: View {
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @Binding var showDatePicker: Bool

    var body: some View {
        HStack(spacing: 10) {
            dateBox(label: "FROM", value: formatted(fromDate))
            Text("→").font(.system(size: 16)).foregroundColor(.gold)
            dateBox(label: "TO", value: formatted(toDate))
        }
        .padding(.horizontal, 28).padding(.bottom, 14)
        .onTapGesture { showDatePicker = true }
        
    }

    private func dateBox(label: String, value: String) -> some View {
        VStack(spacing: 3) {
            Text(label).font(.system(size: 11, weight: .medium)).tracking(0.5)
                .foregroundColor(.navySub)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(value).font(.system(size: 16, weight: .semibold))
                .foregroundColor(.navy)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 14).frame(height: 56)
        .background(Color.cardBG)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.line, lineWidth: 1))
    }

    private func formatted(_ d: Date) -> String {
        let f = DateFormatter(); f.dateFormat = "yyyy.MM.dd"; return f.string(from: d)
    }
}

struct NavSearchBar: View {
    @Binding var searchText: String
    let onSearch: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16)).foregroundColor(.navySub)
            TextField("Search title, orchestra, or performer", text: $searchText)
                .font(.system(size: 14)).foregroundColor(.navy)
                .autocorrectionDisabled()
                .onChange(of: searchText) { _, _ in onSearch() }
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                    onSearch()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 15)).foregroundColor(.navySub)
                }
            }
        }
        .padding(.horizontal, 16).frame(height: 50)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 28).padding(.bottom, 14)
        
    }
}
