//
//  CurrentLocationViewModel.swift
//  Sky
//
//  Created by 疯狂的石头 on 2018/10/19.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation

struct CurrentLocationViewModel {
    var location: Location
    
    var city: String {
        return location.name
    }
    
    static let empty = CurrentLocationViewModel(location: Location.empty)
    
    var isEmpty: Bool {
        return self.location == Location.empty
    }
}
