//
//  ModelComponents.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 10/04/24.
//

import Foundation


struct Location: Codable {
    var countryName: String
    var cityName: String
    var localTime: String
    var lat: Double
    var lon: Double
    
    enum CodingKeys: String, CodingKey {
        case countryName = "country"
        case cityName = "name"
        case localTime = "localtime"
        case lat = "lat"
        case lon = "lon"
    }
}


struct Current: Codable {
    var currentTempC: Double
    var currentTempF: Double
    
    enum CodingKeys: String, CodingKey {
        case currentTempC = "temp_c"
        case currentTempF = "temp_f"
    }
}


struct ForecastDay: Codable {
    var date: String
    var days: [Day]
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case days = "day"
    }
}


struct Day: Codable {
    
}

