//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import XCTest

@testable import Sky

class WeatherDataManagerTest: XCTestCase {

    let url = URL(string: "https://darksky.net")!
    var session: MockURLSession!
    var manager: WeatherDataManager!
    
    override func setUp() {
        super.setUp()
        self.session = MockURLSession()
        self.manager = WeatherDataManager(baseURL: url, urlSession: session)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_weatherDataAt_starts_the_session() {
        let dataTask = MockURLSessionDataTask()
        session.sessionDataTask = dataTask
        
        manager = WeatherDataManager(baseURL: url, urlSession: session)
        manager.weatherDataAt(latitude: 52, longitude: 116) { (_, _) in
            
        }
        
        XCTAssert(dataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_gets_data() {
        let expect = expectation(description: "Loading data from\(API.authenticateUrl)")
        var data: WeatherData? = nil
        WeatherDataManager.shared.weatherDataAt(latitude: 52, longitude: 100) { (response, error) in
            data = response
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func test_weatherDataAt_handle_invaid_request() {
        session.responseError = NSError(
            domain: "Invalid Request",
            code: 100,
            userInfo: nil)
        
        var error: DataManagerError? = nil
        manager.weatherDataAt(latitude: 52, longitude: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_statuscode_not_equal_200() {
        session.responseHeader = HTTPURLResponse(
            url: url,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil)
        
        let data = "{}".data(using: .utf8)
        session.responseData = data
        
        var error: DataManagerError? = nil
        manager.weatherDataAt(latitude: 52, longitude: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_invalid_reponse() {

        session.responseHeader = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let data = "{".data(using: .utf8)
        session.responseData = data
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.invalidResponse)
    }
    
    func test_weatherDataAt_handle_response_decode() {

        session.responseHeader = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let data = """
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

            "daily": {
                "data": [
                    {
                        "time": 1507180335,
                        "icon": "clear-day",
                        "temperatureLow": 66,
                        "temperatureHigh": 82,
                        "humidity": 0.25
                    }
                ]
            }
        }
        """.data(using: .utf8)
        session.responseData = data
        
        var decoded: WeatherData? = nil

        manager.weatherDataAt(
            latitude: 52,
            longitude: 100) { (d, nil) in
                decoded = d
        }
        
        let expectedWeekData = WeatherData.WeekWeatherData(
            data: [ForecastData(time:
                Date(timeIntervalSince1970: 1507180335),
                                temperatureLow: 66,
                                temperatureHigh: 82,
                                icon: "clear-day",
                                humidity: 0.25)])
        
        let expected = WeatherData(
            latitude: 52,
            longitude: 100,
            currently: WeatherData.CurrentWeather(
                time: Date(timeIntervalSince1970: 1507180335),
                summary: "Light Snow",
                icon: "snow",
                temperature: 23,
                humidity: 0.91),
                daily: expectedWeekData)
        
        XCTAssertEqual(decoded, expected)
        
    }
    
}
