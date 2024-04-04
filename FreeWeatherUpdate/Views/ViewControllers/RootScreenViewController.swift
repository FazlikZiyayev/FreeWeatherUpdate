//
//  RootScreenViewController.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 02/04/24.
//

import UIKit
import Combine


class RootScreenViewController: UIViewController {
    
    let model: RootScreenViewModelProtocol = RootScreenViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        
        return label
    }()
    
    private lazy var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup_uiComponents()
        bind_components()
        
        model.fetch_currentWeather()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    func setup_uiComponents() {
        setup_countryNameLabel()
        setup_currentWeatherLabel()
    }
    
    
    func bind_components() {
        bind_currentWeatherPublisher()
    }
    
    
    
    func bind_currentWeatherPublisher() {
        model.currentWeatherPublisher
            .receive(on: RunLoop.main)
            .sink { completion in
            } receiveValue: { [weak self] weather in
                if let safeWeather = weather {
                    self?.countryNameLabel.text = safeWeather.name
                    self?.currentWeatherLabel.text = "\(Int(safeWeather.main.temp))°C"
                }
            }
            .store(in: &cancellables)
    }
}


extension RootScreenViewController {
    func setup_countryNameLabel() {
        view.addSubview(countryNameLabel)
        
        NSLayoutConstraint.activate([
            countryNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: 30)
        ])
    }
    
    
    func setup_currentWeatherLabel() {
        view.addSubview(currentWeatherLabel)
        
        NSLayoutConstraint.activate([
            currentWeatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor,
                                                     constant: 20)
        ])
    }
}
