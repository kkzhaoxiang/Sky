//
//  WeatherData.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation

struct WeatherData: Codable, Equatable {
    
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    let daily: WeekWeatherData
    
    struct WeekWeatherData: Codable, Equatable {
        let data: [ForecastData]
    }
    
    struct CurrentWeather: Codable, Equatable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
    
    static let empty = WeatherData(
        latitude: 0,
        longitude: 0,
        currently: CurrentWeather(time: Date(),
                                  summary: "",
                                  icon: "",
                                  temperature: 0,
                                  humidity: 0),
        daily: WeekWeatherData(data: []))
}

