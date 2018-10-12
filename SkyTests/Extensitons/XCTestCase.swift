//
//  XCTestCase.swift
//  SkyTests
//
//  Created by 疯狂的石头 on 2018/10/12.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadDataFromBundle(ofName name: String, ext :String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: ext)
        return try! Data(contentsOf: url!)
    }
}
