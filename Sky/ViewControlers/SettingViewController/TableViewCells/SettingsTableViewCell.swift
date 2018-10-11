//
//  SettingsTableViewCell.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/11.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SettingsTableViewCell"
    
    @IBOutlet var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with vm: SettingRepresentable) {
        self.accessoryType = vm.accessory
        self.label.text = vm.labelText
    }

}
