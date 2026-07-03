//
//  ContentCard.swift
//  APIService
//
//  Created by Subin on 7/3/26.
//

import SwiftUI

struct ConcertCard: View {
    let concert: Concert
    var body: some View {
        HStack(spacing: 14) {
            poster
            VStack(alignment: .leading, spacing: 4) {
                Text(concert.name)
                    .font(.custom("PlayfairDisplay-Bold", size: 16))
                    .foregroundColor(.navy).lineLimit(2)
                
                Text(concert.place)
                    .font(.custom("PTSerif-Italic", size: 12))
                    .foregroundColor(.gold).lineLimit(1)

                Text("\(concert.startDate)  ·  \(concert.endDate)")
                    .font(.system(size: 12)).foregroundColor(.navySub)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 14).padding(.trailing, 16).padding(.vertical, 14)
        .frame(height: 112)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.line, lineWidth: 1))
    }

    private var poster: some View {
        Group {
                placeholderNote
        }
        .frame(width: 62, height: 84)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var placeholderNote: some View {
        ZStack {
            Color.chipBG
            Image(systemName: "music.note").font(.system(size: 22)).foregroundColor(.gold)
        }
    }

}
