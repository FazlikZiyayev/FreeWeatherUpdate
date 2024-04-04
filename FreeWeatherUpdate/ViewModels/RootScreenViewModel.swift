//
//  RootScreenViewModel.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 02/04/24.
//

import Foundation
import Combine


protocol RootScreenViewModelProtocol {
    var data: CurrentWeather? { get set }
    
    var currentWeather: CurrentWeather? { get }
    var currentWeatherPublisher: Published<CurrentWeather?>.Publisher { get }
    
    func fetch_currentWeather()
}



class RootScreenViewModel: RootScreenViewModelProtocol {
    var data: CurrentWeather?
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var currentWeather: CurrentWeather? = nil
    var currentWeatherPublisher: Published<CurrentWeather?>.Publisher { $currentWeather }
    
    
    func fetch_currentWeather() {
        let urlStr = "\(NetworkConstants.shared.baseUrl)/data/2.5/weather?q=Uzbekistan&appid=\(NetworkConstants.shared.apiKey)&units=metric"
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
                        print("Completed")
                        break
                    case .failure(let error):
                        print("Receiver error \(error)")
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
}
