//
//  WeekWeatherViewModel.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/10.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

struct WeekWeatherViewModel {
    let weatherData: [ForecastData]

    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeekWeatherDayViewModel {
        return WeekWeatherDayViewModel(weatherData: weatherData[index])
    }
}
