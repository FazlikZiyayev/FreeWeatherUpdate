//
//  CurrentForecast.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 10/04/24.
//

import Foundation


struct CurrentForecast: Codable {
    var location: Location
    var current: Current
    var forecast: Forecast
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
        case forecast = "forecast"
    }
}
