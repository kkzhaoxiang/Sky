//
//  CurrentWeahterViewController.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: CurrentWeahterViewController)
    func settingButtonPressed(controller: CurrentWeahterViewController)

}

class CurrentWeahterViewController: WeatherViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?

    var viewModel: CurrentWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        delegate?.settingButtonPressed(controller: self)
    }
    
    func updateView() {
        activityIndicatorView.startAnimating()
        
        if let vm = viewModel, vm.isUpdateReady {
            updateWeatherContainer(with: vm)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Connot load fetch weather/location data from the network."
        }
    }
    
    func updateWeatherContainer(with viewModel: CurrentWeatherViewModel)  {
        weatherContrainerView.isHidden = false
        
        locationLabel.text = viewModel.city
        temperatureLabel.text = viewModel.temperature
        weatherIcon.image = viewModel.weatherIcon
        humidityLabel.text = viewModel.humidity
        summaryLabel.text = viewModel.summary
        dateLabel.text = viewModel.date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

