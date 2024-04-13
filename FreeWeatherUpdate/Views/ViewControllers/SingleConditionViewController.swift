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
        
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup_conditionTB()
        bind_currentForecast()
    }
    
    
    func setCurrentForecast(forecast: CurrentForecast) {
        model.setCurrentForecast(forecast: forecast)
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
        4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCellIdentifier",
                                                    for: indexPath) as? ForecastCell {
            cell.configure(withTitle: "Hello")
            
            return cell
        }
        
        return UITableViewCell()
    }
}


extension SingleConditionViewController {
    
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
