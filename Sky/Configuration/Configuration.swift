//
//  Configuration.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation

struct API {
    static let key = "0d234c215987c46b4bdce9a2450efb2e"
    static var baseUrl = URL(string: "https://api.darksky.net/forecast")!
    static let authenticateUrl = baseUrl.appendingPathComponent(key)
}
