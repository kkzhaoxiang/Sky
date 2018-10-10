//
//  CurrentWeatherTest.swift
//  SkyUITests
//
//  Created by 疯狂的石头 on 2018/10/10.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import XCTest

class CurrentWeatherTest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments += ["UI-TESTING"]
        let json = """
        {
            "longitude" : 100,
            "latitude" : 52,
            "currently" : {
                "temperature" : 23,
                "humidity" : 0.91,
                "icon" : "snow",
                "time" : 1507180335,
                "summary" : "Light Snow"
            }
        }
        """
        app.launchEnvironment["FakeJSON"] = json
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_location_button_exists() {
        let locationBtn = app.buttons["LocationBtn"]
        let exists = NSPredicate(format: "exists == true")
        
        expectation(for: exists, evaluatedWith: locationBtn, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssert(locationBtn.exists)
    }
    
    func test_currently_weather_display() {
        XCTAssert(app.images["snow"].exists)
        XCTAssert(app.staticTexts["Light Snow"].exists)
    }
}
