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

    var now: WeatherData? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    var location: Location? {
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
        
        if let now = now, let location = location {
            updateWeatherContainer(with: now, at: location)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Connot load fetch weather/location data from the network."
        }
    }
    
    func updateWeatherContainer(with data: WeatherData, at location: Location)  {
        weatherContrainerView.isHidden = false
        
        // Set location
        locationLabel.text = location.name
        
        // Format and set temperature
        temperatureLabel.text = String(format: "%.1f °C", data.currently.temperature.toCelcius())
        
        // Set weather icon
        weatherIcon.image = weatherIcon(of: data.currently.icon)
        
        // Format and set humidity
        humidityLabel.text = String(format: "%.1f", data.currently.humidity)
        
        // Set weather summary
        summaryLabel.text = data.currently.summary
        
        // Format and set datetime
        let fmt = DateFormatter()
        fmt.dateFormat = "E, dd MMMM"
        dateLabel.text = fmt.string(from: data.currently.time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

