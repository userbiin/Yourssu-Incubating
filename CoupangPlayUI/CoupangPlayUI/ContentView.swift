//
//  ContentView.swift
//  CoupangPlayUI
//
//  Created by Subin on 6/15/26.
//

import SwiftUI


// main (컴포넌트들 쌓기)
struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray900.ignoresSafeArea()

            VStack(spacing: 0) {
                NavBar()

                ScrollView {
                    VStack(spacing: 30) {
                        // figma 상으로는 각 뷰들 간 거리가 8이던데 spacing을 8로 하면 너무 좁게 보이네요... spacing: 8 로 설정하는게 맞나요??
                        BannerCarousel(banners: MockData.banners)
                            .padding(.top, 8)

                        ForEach(MockData.homeRows) { row in
                            switch row {
                            case .posters(let section):
                                ContentRow(section: section)
                            case .banner(let content):
                                horizontalBanner(content: content)
                            case .icons(let items):
                                    IconRow(items: items)
                            }
                        }
                    }
                }
                TabBar()
            }
        }
    }
}

#Preview("ContentView") {
    ContentView()
}
