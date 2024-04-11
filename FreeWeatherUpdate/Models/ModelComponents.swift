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


struct Forecast: Codable {
    var forecastDays: [ForecastDay]
    
    enum CodingKeys: String, CodingKey {
        case forecastDays = "forecastday"
    }
}


struct ForecastDay: Codable {
    var date: String
    var day: Day
    var hours: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case day = "day"
        case hours = "hour"
    }
}


struct Day: Codable {
    var maxTempC: Double
    var avgTempC: Double
    var minTempC: Double
    
    enum CodingKeys: String, CodingKey {
        case maxTempC = "maxtemp_c"
        case avgTempC = "avgtemp_c"
        case minTempC = "mintemp_c"
    }
}


struct Hour: Codable {
    var time: String
    var currentTempC: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case currentTempC = "temp_c"
    }
}
