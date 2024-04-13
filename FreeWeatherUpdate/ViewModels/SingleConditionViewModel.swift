//
//  SingleConditionViewModel.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 13/04/24.
//

import Foundation
import Combine


protocol SingleConditionViewModelProtocol {
    
    var currentForecast: CurrentForecast? { get }
    var currentForecastPublisher: Published<CurrentForecast?>.Publisher { get }
    
    func setCurrentForecast(forecast: CurrentForecast?)
}


class SingleConditionViewModel: SingleConditionViewModelProtocol {
    
    @Published var currentForecast: CurrentForecast? = nil
    var currentForecastPublisher: Published<CurrentForecast?>.Publisher { $currentForecast }
    
    
    
    func setCurrentForecast(forecast: CurrentForecast?) {
        currentForecast = forecast
    }
}

