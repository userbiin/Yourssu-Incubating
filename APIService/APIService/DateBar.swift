//
//  DateBar.swift
//  APIService
//
//  Created by Subin on 7/3/26.
//

import SwiftUI

struct DatePickerSheet: View {
    @Binding var fromDate: Date
    @Binding var toDate: Date
    var onApply: () -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var editing: Field = .from
    enum Field { case from, to }

    var body: some View {
        VStack(spacing: 20) {
            Capsule().fill(Color.line).frame(width: 40, height: 4).padding(.top, 8)

            Text("Select Period")
                .font(.custom("PlayfairDisplay-Bold", size: 24))
                .foregroundColor(.navy)
                .frame(maxWidth: .infinity, alignment: .leading)

            segmentedField

            if editing == .from {
                DatePicker(
                    "",
                    selection: $fromDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .tint(.gold)
                .labelsHidden()
            } else {
                DatePicker(
                    "",
                    selection: $toDate,
                    in: fromDate...,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .tint(.gold)
                .labelsHidden()
            }

            Button {
                onApply(); dismiss()
            } label: {
                Text("Apply")
                    .font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                    .frame(maxWidth: .infinity).frame(height: 52)
                    .background(Color.navy)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 28)
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }


    private var segmentedField: some View {
        HStack(spacing: 4) {
            segItem(.from, label: "FROM", date: fromDate)
            segItem(.to,   label: "TO",   date: toDate)
        }
        .padding(4)
        .background(Color.cardBG)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func segItem(_ field: Field, label: String, date: Date) -> some View {
        let active = editing == field
        return VStack(spacing: 2) {
            Text(label).font(.system(size: 10, weight: .medium)).tracking(0.5)
                .foregroundColor(active ? .gold : .navySub)
            Text(ContentView.string(date))
                .font(.system(size: 15, weight: .semibold)).foregroundColor(.navy)
        }
        .frame(maxWidth: .infinity).frame(height: 48)
        .background(active ? Color.white : Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 9)
                .stroke(active ? Color.gold : Color.clear, lineWidth: 1.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 9))
        .onTapGesture { editing = field }
    }
    
}


