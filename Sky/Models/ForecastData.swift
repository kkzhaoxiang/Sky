//
//  ForecastData.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/10.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation

struct ForecastData: Codable, Equatable {
    let time: Date
    let temperatureLow: Double
    let temperatureHigh: Double
    let icon: String
    let humidity: Double
}
