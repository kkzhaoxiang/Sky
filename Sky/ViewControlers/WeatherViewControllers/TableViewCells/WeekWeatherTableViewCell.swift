//
//  WeekWeatherTableViewCell.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/10.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentfier = "WeekWeatherCell"
    
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
