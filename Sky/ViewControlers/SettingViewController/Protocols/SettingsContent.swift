//
//  SettingsContent.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/11.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

protocol SettingRepresentable {
    var labelText: String { get }
    var accessory: UITableViewCell.AccessoryType { get }
}
