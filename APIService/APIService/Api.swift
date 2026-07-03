//
//  Api.swift
//  APIService
//
//  Created by Subin on 7/3/26.
//
import SwiftUI

enum ConcertError: Error, LocalizedError {
    case badURL, responseError, decodingError
    var errorDescription: String? {
        switch self {
        case .badURL:        return "Invalid request URL."
        case .responseError: return "Server error. Is the proxy running?"
        case .decodingError: return "Failed to read the data."
        }
    }
}

final class ConcertService {
    static let shared = ConcertService()
    private init() {}

    private let baseURL = "http://localhost:8000"

    func fetchClassicConcerts(startDate: String, endDate: String,
                              keyword: String? = nil) async throws -> [Concert] {
        var comp = URLComponents(string: "\(baseURL)/classic")
        var items = [
            URLQueryItem(name: "stdate", value: startDate),
            URLQueryItem(name: "eddate", value: endDate),
        ]
        if let keyword, !keyword.isEmpty {
            items.append(URLQueryItem(name: "keyword", value: keyword))
        }
        comp?.queryItems = items
        guard let url = comp?.url else { throw ConcertError.badURL }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse,
              (200...299).contains(http.statusCode) else {
            throw ConcertError.responseError
        }
        do {
            return try JSONDecoder().decode(ConcertListResponse.self, from: data).concerts
        } catch {
            throw ConcertError.decodingError
        }
    }
}


enum LoadState {
    case idle, loading, loaded, failed(String)
}
