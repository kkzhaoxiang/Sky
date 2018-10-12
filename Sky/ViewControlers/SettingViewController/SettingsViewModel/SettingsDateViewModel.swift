//
//  SettingsDateViewModel.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/11.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

struct SettingsDateViewModel {
    let dateMode: DateMode
    
    var labelText: String {
        return dateMode == .text ? "Fri, 01 December" : "F, 12/01"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        if UserDefaults.dateMode() == .text {
            return .checkmark
        } else {
            return .none
        }
    }
}


extension SettingsDateViewModel: SettingRepresentable {}
