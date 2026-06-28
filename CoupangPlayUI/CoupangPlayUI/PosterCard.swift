//
//  PosterCard.swift
//  CoupangPlayUI
//
//  Created by Subin on 6/19/26.
//

import SwiftUI

// 카드 1개 객체 
struct PosterCard: View {
    let content: Content
    
    var body: some View {
        Image(content.imageName)
            .resizable()
            .aspectRatio(2/3, contentMode: .fill)
            .frame(width: Layout.posterCardWidth)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .topLeading) {
                            if let tag = content.tag {
                                Image(tag)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 22)
                            }
                        }
            .padding(8)
    }
}

// 포스터에 숫자 겹치기
// @ViewBuilder func
struct RankedCard: View {
    let content: Content
    var body: some View {
//HStack 대신 ZStack? -> 간격이 이상하게 출력되네요
//        ZStack(alignment: .bottomLeading){
//            Image(content.imageName).resizable()
//                .aspectRatio(2/3, contentMode: .fill)
//                .frame(width: 115, height: 174)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .padding(10)
//            
//            
//            Text("\(content.rank ?? 0)")
//                .font(.system(size: 90, weight: .bold))
//                .foregroundColor(.white)
//                .opacity(0.6)
//                .offset(x: -20, y: 20)
//        }
        
        HStack(alignment: .bottom, spacing: -30){
            Text("\(content.rank ?? 0)")
                .font(.system(size: 90, weight: .bold))
                .foregroundColor(.white)
                .zIndex(1)
                .opacity(0.6)
                .offset(y: 22)
            
            Image(content.imageName)
                .resizable()
                .aspectRatio(2/3, contentMode: .fill)
                .frame(width: Layout.posterCardWidth)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .topLeading) {
                                if let tag = content.tag {
                                    Image(tag)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 22)
                                    //.clipShape(RoundedRectangle(cornerRadius: 7))
                                    // overlay 붙인 왼쪽 상단만 radius 주는 법? 
                                }
                            }

            }
        }
    }


// item 에 rank 가 있으면 분기
struct ContentRow: View {
    let section: ContentSection
    var body: some View{
        VStack(alignment: .leading, spacing: 8){
            HStack {
                Text(section.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(){
                    ForEach(section.items) {
                        item in
                        if item.rank != nil {
                            RankedCard(content: item)
                        } else {
                            PosterCard(content: item)
                        }
                    }
                }
            }
        }
    }
}


// 가로 배너
struct horizontalBanner: View {
    let content: Content
    var body: some View {
        Image(content.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
    }
}


// 작은 배너
struct IconCard: View {
    let content: Content
    var body: some View {
        VStack() {
            Image(content.imageName)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: Layout.iconCardWidth)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity)  // maxwidth
    }
}


//IconCard 크기 여기서 지정
struct IconRow: View {
    let items: [Content]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(items) { item in
                    IconCard(content: item)
                }
            }
        }
    }
}
