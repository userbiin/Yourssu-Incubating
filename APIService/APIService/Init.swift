//
//  Init.swift
//  APIService
//
//  Created by Subin on 7/3/26.
//

struct ConcertListResponse: Codable {
    let count: Int
    let concerts: [Concert]
}

struct Concert: Codable, Identifiable {
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let place: String
    let posterURL: String
    let area: String
    let genre: String
    let state: String
    let program: String
    
}
