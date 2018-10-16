//
//  LocationViewModel.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/15.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationsViewModel {
    let location: CLLocation?
    let locationText: String?
}

extension LocationsViewModel: LocationRepresentable {

    var labelText: String {
        
        if let locationText = locationText {
            return locationText
        } else if let location = location {
            return location.toString
        }
        
        return "Unknow position"
    }
    
    var locationCity: String {
        if let locationText = locationText {
            return locationText
        } else if let location = location {
            return location.toLocationCity
        }
        
        return "Unknow position"
    }
}
