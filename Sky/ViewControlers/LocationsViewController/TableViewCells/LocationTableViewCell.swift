//
//  LocationTableViewCell.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/15.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    static let reuseIdentifier = "LocationCell"
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: LocationRepresentable) {
        label.text = viewModel.labelText
    }
}
