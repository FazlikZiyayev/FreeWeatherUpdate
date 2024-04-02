//
//  NetworkConstants.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 02/04/24.
//

import Foundation


class NetworkConstants {
    static let shared = NetworkConstants()
    
    let apiKey = "242847f9f1ebe60a82f970bbbe512e52"
    let baseUrl = "https://api.openweathermap.org"
    
    private init () {}
}
