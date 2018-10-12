//
//  SettingsTemperatureViewModel.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/11.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

struct SettringsTemperatureViewModel {
    let temperatureMode: TemperatureMode
    
    var labelText: String {
        return temperatureMode == .celsius ? "Celsius" : "Fahrenheit"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        if UserDefaults.temperatureMode() == temperatureMode {
            return .checkmark
        }
        else {
            return .none
        }
    }
}

extension SettringsTemperatureViewModel: SettingRepresentable { }
