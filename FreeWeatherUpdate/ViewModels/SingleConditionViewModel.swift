//
//  SingleConditionViewModel.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 13/04/24.
//

import Foundation
import Combine


protocol SingleConditionViewModelProtocol {
    
    var currentForecast: ForecastDay? { get }
    var currentForecastPublisher: Published<ForecastDay?>.Publisher { get }
    
    func setCurrentForecast(forecast: ForecastDay?)
}


class SingleConditionViewModel: SingleConditionViewModelProtocol {
    
    @Published var currentForecast: ForecastDay? = nil
    var currentForecastPublisher: Published<ForecastDay?>.Publisher { $currentForecast }
    
    
    
    func setCurrentForecast(forecast: ForecastDay?) {
        currentForecast = forecast
    }
}

