//
//  BarView.swift
//  CoupangPlayUI
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        VStack(){
            HStack(){
                Image("logo")
                Spacer()
                HStack(spacing: 4){
                    Text("카테고리")
                    Image("chevron_down")
                }
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.trailing, 32)
            }
        }
        
        HStack(spacing: 20) {  //\.self
            ForEach(["TV", "영화", "스포츠", "스토어", "키즈", "라이브"], id: \.self) { tab in
                Image(tab)
            }
        }
        .padding(20)
    }
}


struct BannerCarousel: View {
    let banners: [Content]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Layout.bannerSpacing){
                ForEach(banners) {
                    banner in BannerView(content: banner)
                        .containerRelativeFrame(
                            .horizontal,
                            count: 1,
                            span: 1,
                            spacing: Layout.bannerSpacing
                        )
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.6)
                                .scaleEffect(phase.isIdentity ? 1 : 0.85)
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, Layout.bannerPeek, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}


struct BannerView: View {
    let content: Content
    var body: some View { //
        ZStack(alignment: .bottom){
            Image(content.imageName)
                .resizable()
                .aspectRatio(354/502, contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .topLeading) {
                                if let tag = content.tag {
                                    Image(tag)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 22)
                                }
                            }
    
            
            Button(action: {
                print("")
            }) {
                Text("오늘 오후 8시 예매하기")
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                // banner 크기랑 동적으로 맞추려고 maxWidth 를 썼는데 banner 크기랑 안 맞게 되네요 ㅜㅜ
                    .padding(.vertical, 10)
                    .background(Color.blue500)
                    .clipShape(RoundedRectangle(cornerRadius: 9))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 15)
        }
    }
}

struct TabBar: View {
    var body: some View {
        HStack {
            VStack(spacing: 4) {
                Image("home")
                    .renderingMode(.template)
                    .foregroundStyle(.white)
                Text("홈")
                    .font(.caption2)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
            }
            VStack(spacing: 4) {
                Image("video")
                    .renderingMode(.template)
                    .foregroundStyle(.gray)
                Text("공개예정")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
            }
            VStack(spacing: 4) {
                Image("search 1")
                    .renderingMode(.template)
                    .foregroundStyle(.gray)
                Text("검색")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
            }
            VStack(spacing: 4) {
                Image("profile")
                    .renderingMode(.template)
                    .foregroundStyle(.gray)
                Text("프로필")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 8)
        .background(Color.gray900)
    }
}




