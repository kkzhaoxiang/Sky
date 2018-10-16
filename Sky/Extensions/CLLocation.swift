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
    
    var toLocationCity: String {
        let geo = CLGeocoder()
        var name: String = ""
        geo.reverseGeocodeLocation(self) { (placemarks, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            } else {
                if let place = placemarks?.first {
                    if let locacity = place.locality {
                        name = locacity
                    } else {
                        name = "Unknow city"
                    }
                } else {
                    name = "Unknow city"
                }
            }
        }
        return name
    }
}
