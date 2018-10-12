//
//  WeekWeatherViewController.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/10.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {

    @IBOutlet weak var weekWeatherTableView: UITableView!
    var viewModel: WeekWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let _ = viewModel {
            updateWeatherDataContainer()
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Loading location/weather failed"
        }
    }
    
    func updateWeatherDataContainer() {
        weatherContrainerView.isHidden = false
        weekWeatherTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    


}

extension WeekWeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.reuseIdentfier, for: indexPath) as? WeekWeatherTableViewCell else {
            fatalError("Unexpected table view cell")
        }
        
        if let vm = viewModel?.viewModel(for: indexPath.row) {
            cell.configure(with: vm)
        }
        
        return cell
    }
    
    
}
