//
//  SingleConditionViewController.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 13/04/24.
//

import UIKit
import Combine


class SingleConditionViewController: UIViewController {
    
    let model: SingleConditionViewModelProtocol = SingleConditionViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    
    private lazy var conditionTB: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = UIColor.clear
        tb.delegate = self
        tb.dataSource = self
        tb.register(ForecastCell.self, forCellReuseIdentifier: "ForecastCellIdentifier")

        return tb
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup_view()
        setup_navigationBar()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup_conditionTB()
        bind_currentForecast()
    }
    
    
    func bind_currentForecast() {
        model.currentForecastPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] forecast in
                self?.conditionTB.reloadData()
            }
            .store(in: &cancellables)
    }
}


extension SingleConditionViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let safeForecast = model.currentForecast else { return 0 }

        return safeForecast.hours.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCellIdentifier",
                                                    for: indexPath) as? ForecastCell {
            guard let safeForecast = model.currentForecast else { return UITableViewCell() }
            
            let currenObj = safeForecast.hours[indexPath.row]
            
            cell.configure(withTitle: formatTimeToHour(currenObj.time) ?? "",
                           withDesc: "\(Int(currenObj.currentTempC))°")
            
            return cell
        }
        
        return UITableViewCell()
    }
}


extension SingleConditionViewController {
    
    func setup_navigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.white

        let blackAppereance = UINavigationBarAppearance()
        blackAppereance.backgroundColor = UIColor.black
        navigationController?.navigationBar.standardAppearance = blackAppereance
        navigationController?.navigationBar.scrollEdgeAppearance = blackAppereance

        guard let safeForecast = model.currentForecast else { return }
        let titleLabel = UILabel()
        titleLabel.text = "\(dayOfWeek(from: safeForecast.date) ?? "")"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
    }
    
    
    func setup_view() {
        view.backgroundColor = UIColor.black
    }
    
    
    func setup_conditionTB() {
        view.addSubview(conditionTB)
        
        NSLayoutConstraint.activate([
            conditionTB.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conditionTB.leftAnchor.constraint(equalTo: view.leftAnchor),
            conditionTB.rightAnchor.constraint(equalTo: view.rightAnchor),
            conditionTB.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}


extension SingleConditionViewController {
    
    func setCurrentForecast(forecast: ForecastDay) {
        model.setCurrentForecast(forecast: forecast)
    }
    
    
    func formatTimeToHour(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = dateFormatter.date(from: dateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h a"
            return timeFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    
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
