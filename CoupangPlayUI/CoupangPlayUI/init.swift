//
//  init.swift
//  CoupangPlayUI
//
//  Created by Subin on 6/19/26.
//

import SwiftUI

// 각 포스터
struct Content: Identifiable {
    let id = UUID()
    let imageName: String
    let rank: Int?
    var tag: String? = nil
}

// 제목 + 그 안의 컨텐츠들
struct ContentSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [Content]
}

// 긴 배너 + 작은 카드용
enum HomeRow: Identifiable {
    case posters(ContentSection)
    case banner(Content)
    case icons([Content])

    var id: UUID {
        switch self {
        case .posters(let section): return section.id
        case .banner(let content): return content.id
        case .icons(let items): return items.first?.id ?? UUID()
        }
    }
}


