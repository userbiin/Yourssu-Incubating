//
//  Mockdata.swift
//  CoupangPlayUI
//
//  Created by Subin on 6/18/26.
//

enum MockData {
    static let banner = Content(imageName: "run_ticket", rank: nil)
    
    static let banners = [
        Content(imageName: "run_ticket", rank: nil, tag: "series_tag"),
        Content(imageName: "run_ticket", rank: nil, tag: "series_tag"),
        Content(imageName: "run_ticket", rank: nil, tag: "series_tag"),
    ]
    
    static let top20 = ContentSection(
        title: "이번주 인기작 TOP 20",
        items: [
            Content(imageName: "snl", rank: 1, tag: "series_tag"),
            Content(imageName: "solo", rank: 2),
            Content(imageName: "ifus", rank: 3, tag: "movie_tag"),
        ]
    )
    static let banner2 = Content(imageName: "ken", rank: nil)
    
    static let newContent = ContentSection(
        title: "새로 올라온 콘텐츠",
        items: [
            Content(imageName: "him", rank: nil, tag: "movie_tag"),
            Content(imageName: "bonjour", rank: nil, tag: "series_tag"),
            Content(imageName: "unknown", rank: nil, tag: "parramount_tag"),
        ]
    )
    
    static let economyContent = ContentSection(
        title: "경제로 보는 세상" ,
        items: [
            Content(imageName: "class", rank: nil, tag: "ebs_tag"),
            Content(imageName: "doctor", rank: nil, tag: "ebs_tag"),
            Content(imageName: "ebs", rank: nil, tag: "ebs_tag"),
            Content(imageName: "ebs2", rank: nil, tag: "ebs_tag"),
        ])
    
    static let fragileContent = ContentSection(
        title: "관계의 균열" ,
        items: [
            Content(imageName: "getout", rank: nil),
            Content(imageName: "findme", rank: nil),
            Content(imageName: "search", rank: nil),
            Content(imageName: "him", rank: nil),
        ])
    
    static let coupangContent = ContentSection(
        title: "오직 쿠팡플레이에서" ,
        items: [
            Content(imageName: "None", rank: nil)
        ]
    )
    
    static let quickIcons = [
        Content(imageName: "ticket_open", rank: nil),
        Content(imageName: "bonjour2", rank: nil),
        Content(imageName: "predict", rank: nil),
        Content(imageName: "romance", rank: nil),
        Content(imageName: "award", rank: nil)
    ]
    
    static let quickIcons2 = [
        Content(imageName: "bonjour3", rank: nil),
        Content(imageName: "bonjour4", rank: nil),
        Content(imageName: "cha", rank: nil),
        Content(imageName: "healing1", rank: nil),
    ]
    
    static let allSections = [top20, newContent, economyContent, fragileContent, coupangContent]
    
    
    static let homeRows: [HomeRow] = [
        .icons(quickIcons),
        .posters(top20),
        .banner(banner2),
        .posters(newContent),
        .posters(economyContent),
        .icons(quickIcons2),
        .posters(fragileContent),
        .posters(coupangContent),
    ]

    
}
