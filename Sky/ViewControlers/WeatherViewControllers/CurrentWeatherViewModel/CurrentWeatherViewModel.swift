//
//  CurrentWeatherViewModel.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/10.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    var isLocationReady = false
    var isWeatherReady = false
    
    var location: Location! {
        didSet {
            if location != nil {
                self.isLocationReady = true
            } else {
                self.isLocationReady = false
            }
        }
    }
    
    var weather: WeatherData! {
        didSet {
            if weather != nil {
                self.isWeatherReady = true
            } else {
                self.isWeatherReady = false
            }
        }
    }
    
    var isUpdateReady: Bool {
        return isLocationReady && isWeatherReady
    }
    
    var weatherIcon: UIImage {
        return UIImage.weatherIcon(of: weather.currently.icon)!
    }
    
    var city: String {
        return location.name
    }
    
    var temperature: String {
        
        let value = weather.currently.temperature
        
        switch UserDefaults.temperatureMode() {
        case .fahrenheit:
            return String(format: "%.1f °C", value)
        case .celsius:
            return String(format: "%.1f °C", value.toCelcius())
        }
    }
    
    var humidity: String {
        return String(format: "%.1f %%", weather.currently.humidity)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = UserDefaults.dateMode().format
        
        return formatter.string(from: weather.currently.time)
    }
}
