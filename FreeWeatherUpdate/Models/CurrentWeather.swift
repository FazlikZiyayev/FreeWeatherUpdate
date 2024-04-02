//
//  CurrentWeather.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 02/04/24.
//

import Foundation


struct CurrentWeather: Codable {
    var main: Main
    var name: String
}


struct Main: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}
