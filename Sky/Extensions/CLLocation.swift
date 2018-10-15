//
//  CLLocation.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/15.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    var toString: String {
        let latitude = String(format: "%.3f", coordinate.latitude)
        let longitude = String(format: "%.3f", coordinate.longitude)
        
        return "\(latitude), \(longitude)"
    }
}
