//
//  SettingTemperatureViewModelTests.swift
//  SkyTests
//
//  Created by 疯狂的石头 on 2018/10/12.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import XCTest

@testable import Sky

class SettingTemperatureViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_temperature_display_in_celsius() {
        let vm = SettringsTemperatureViewModel(temperatureMode: .celsius)
        XCTAssertEqual(vm.labelText, "Celsius")
    }
    
    func test_temperature_display_in_fahrenheit() {
        let vm = SettringsTemperatureViewModel(temperatureMode: .fahrenheit)
        XCTAssertEqual(vm.labelText, "Fahrenheit")
    }
    
    func test_temperature_celsius_selected() {
        let temperatureMode: TemperatureMode = .celsius
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettringsTemperatureViewModel(temperatureMode: temperatureMode)
        
        XCTAssertEqual(vm.accessory, .checkmark)
    }
    
    func test_temperature_celsius_unselected() {
        let temperatureMode: TemperatureMode = .celsius
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettringsTemperatureViewModel(temperatureMode: .fahrenheit)
        
        XCTAssertEqual(vm.accessory, .none)
    }
    
    func test_temperature_fahrenheit_selected() {
        let temperatureMode: TemperatureMode = .fahrenheit
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettringsTemperatureViewModel(temperatureMode: temperatureMode)
        
        XCTAssertEqual(vm.accessory, .checkmark)
    }
    
    func test_temperature_fahrenheit_unselected() {
        let temperatureMode: TemperatureMode = .fahrenheit
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        let vm = SettringsTemperatureViewModel(temperatureMode: .celsius)
        
        XCTAssertEqual(vm.accessory, .none)
    }

}
