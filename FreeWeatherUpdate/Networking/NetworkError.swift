//
//  NetworkError.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 13/04/24.
//

import Foundation


enum NetworkError: Error {
    case invalidURL
    case noInternetConnection
    case serverError(Int)
    case notFound
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noInternetConnection:
            return "No internet connection"
        case .serverError(let statusCode):
            return "Server Error: \(statusCode)"
        case .notFound:
            return "Not Found"
        case .invalidResponse:
            return "Invalid response"
        }
    }
}
