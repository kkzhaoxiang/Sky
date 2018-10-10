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
        return String(format: "%.1f °C", weather.currently.temperature.toCelcius())
    }
    
    var humidity: String {
        return String(format: "%.1f %%", weather.currently.humidity)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        
        return formatter.string(from: weather.currently.time)
    }
}
