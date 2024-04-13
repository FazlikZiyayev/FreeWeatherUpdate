//
//  NetworkConstants.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 02/04/24.
//

import Foundation


public class NetworkConstants {
    public static let shared = NetworkConstants()
    
    let apiKey = "515ba21b6d7e4d459be112150241004"
    let baseUrl = "http://api.weatherapi.com/v1"
    
    private init () {}
}
