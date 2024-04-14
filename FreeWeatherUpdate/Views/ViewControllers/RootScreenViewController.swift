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
        label.font = UIFont.systemFont(ofSize: 92)
        
        return label
    }()
    
    
    private lazy var forecastTB: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = UIColor.clear
        tb.delegate = self
        tb.dataSource = self
        tb.register(ForecastCell.self, forCellReuseIdentifier: "ForecastCellIdentifier")
        
        return tb
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup_uiComponents()
        bind_components()
        
        model.fetch_forecastWeather()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .black
    }
    
    
    
    func setup_uiComponents() {
        setup_countryNameLabel()
        setup_currentWeatherLabel()
        setup_forecastTB()
    }
    
    
    func bind_components() {
        bind_currentWeatherPublisher()
        bind_currentForecastPublisher()
    }
    
    
    
    func bind_currentWeatherPublisher() {
        model.currentWeatherPublisher
            .receive(on: RunLoop.main)
            .sink { completion in
            } receiveValue: { [weak self] weather in
                if let safeWeather = weather {
                    self?.countryNameLabel.text = safeWeather.location.cityName
                    self?.currentWeatherLabel.text = "\(Int(safeWeather.current.currentTempC))°"
                }
            }
            .store(in: &cancellables)
    }
    
    
    func bind_currentForecastPublisher() {
        model.currentForecastPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] forecast in
                if let safeForecast = forecast {
                    self?.countryNameLabel.text = safeForecast.location.cityName
                    self?.currentWeatherLabel.text = "\(Int(safeForecast.current.currentTempC))°"
                    
                    self?.forecastTB.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}


extension RootScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let safeForecast = model.currentForecast
        {
            let vc = SingleConditionViewController()
            vc.setCurrentForecast(forecast: safeForecast.forecast.forecastDays[indexPath.row])
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let safeForecast = model.currentForecast else { return 0 }
        
        return safeForecast.forecast.forecastDays.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCellIdentifier",
                                                    for: indexPath) as? ForecastCell {
            
            guard let safeForecast = model.currentForecast else { return UITableViewCell() }
            
            let str = safeForecast.forecast.forecastDays[indexPath.row].date
            cell.configure(withTitle: dayOfWeek(from: str) ?? str,
                           withDesc: "\(Int(safeForecast.forecast.forecastDays[indexPath.row].day.avgTempC))°")
            
            
            return cell
        }
        
        return UITableViewCell()
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
                                                     constant: 30)
        ])
    }
    
    
    func setup_forecastTB() {
        view.addSubview(forecastTB)
        
        NSLayoutConstraint.activate([
            forecastTB.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor,
                                            constant: 20),
            forecastTB.leftAnchor.constraint(equalTo: view.leftAnchor),
            forecastTB.rightAnchor.constraint(equalTo: view.rightAnchor),
            forecastTB.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor)
        ])
    }
}


extension RootScreenViewController {
    
    func dayOfWeek(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return "Today"
        } else {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: date)
        }
    }
}
