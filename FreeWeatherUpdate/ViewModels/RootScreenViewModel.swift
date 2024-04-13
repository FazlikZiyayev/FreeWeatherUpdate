//
//  RootScreenViewModel.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 02/04/24.
//

import Foundation
import Combine


// Here we can use Observer design pattern
protocol RootScreenViewModelProtocol {
  
    var currentWeather: CurrentWeather? { get }
    var currentWeatherPublisher: Published<CurrentWeather?>.Publisher { get }
    
    var currentForecast: CurrentForecast? { get }
    var currentForecastPublisher: Published<CurrentForecast?>.Publisher { get }
    
    func fetch_currentWeather()
    func fetch_forecastWeather()
}



class RootScreenViewModel: RootScreenViewModelProtocol {
    var cancellables = Set<AnyCancellable>()
    
    @Published var currentWeather: CurrentWeather? = nil
    @Published var currentForecast: CurrentForecast? = nil

    var currentWeatherPublisher: Published<CurrentWeather?>.Publisher { $currentWeather }
    var currentForecastPublisher: Published<CurrentForecast?>.Publisher { $currentForecast }
    
    
    func fetch_currentWeather() {
        let urlStr = "\(NetworkConstants.shared.baseUrl)/current.json?key=\(NetworkConstants.shared.apiKey)&q=Uzbekistan"
        guard let safeUrl = URL(string: urlStr) else { return }
        
        let session = URLSession.shared
        
        session.dataTaskPublisher(for: safeUrl)
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse,
                   (200...299).contains(response.statusCode) else
                {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: CurrentWeather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(
                //. completion when the publisher completes with failure or no error
                receiveCompletion: { status in
                    switch status {
                    case .finished:
                        print("Finished: fetch_currentWeather")
                        break
                    case .failure(_):
                        print("Failed: fetch_currentWeather")
                        break
                    }
                },
                // receive the data
                receiveValue: { [weak self] weather in
                    self?.currentWeather = weather
                }
            )
            .store(in: &cancellables)
    }
    
    
    
    func fetch_forecastWeather() {
        let urlStr = "\(NetworkConstants.shared.baseUrl)/forecast.json?key=\(NetworkConstants.shared.apiKey)&q=Uzbekistan&days=10"
        guard let safeUrl = URL(string: urlStr) else { return }
        
        let session = URLSession.shared
        
        session.dataTaskPublisher(for: safeUrl)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else
                {
                          throw URLError(.badServerResponse)
                }
                
                return data
            }
            .receive(on: DispatchQueue.global())
            .decode(type: CurrentForecast.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished: fetch_forecastWeather")
                    break
                case .failure(_):
                    print("Failed: fetch_forecastWeather")
                    break
                }
            } receiveValue: { [weak self] forecast in
                self?.currentForecast = forecast
            }
            .store(in: &cancellables)

        
    }
}
