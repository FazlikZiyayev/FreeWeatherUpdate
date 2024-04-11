//
//  CurrentWeather.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 02/04/24.
//

import Foundation


struct CurrentWeather: Codable {
    var location: Location
    var current: Current
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case current = "current"
    }
}
