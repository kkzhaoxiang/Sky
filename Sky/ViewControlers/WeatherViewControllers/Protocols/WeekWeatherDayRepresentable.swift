//
//  WeekWeatherDayRepresentable.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/11.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit


protocol WeekWeatherDayRepresentable {
    var week: String { get }
    var date: String { get }
    var temperature: String { get }
    var weatherIcon: UIImage? { get }
    var humidity: String { get }
}
