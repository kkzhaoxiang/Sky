//
//  WeahterDataManager.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

internal class DarkSkyURLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol {
        return DarkSkyURLSessionDataTask(request: request, completion: completionHandler)
    }
}

internal class DarkSkyURLSessionDataTask: URLSessionDataTaskProtocol {
    private let request: URLRequest
    private let completion: DataTaskHandler
    
    init(request: URLRequest, completion: @escaping DataTaskHandler) {
        self.request = request
        self.completion = completion
    }
    
    func resume() {
        let json = ProcessInfo.processInfo.environment["FakeJSON"]
        
        if let json = json {
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            let data = json.data(using: .utf8)
            
            completion(data, response, nil)
        }
    }
}

internal struct Config {
    private static func isUITesting() -> Bool {
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
    
    static var urlSession: URLSessionProtocol = {
        if isUITesting() {
            return DarkSkyURLSession()
        } else {
            return URLSession.shared
        }
    }()
}

enum DataManagerError {
    case failedRequest
    case invalidResponse
    case unknow
}

final class WeatherDataManager {
    
    internal let baseURL: URL
    internal let urlSession: URLSessionProtocol
    internal init(baseURL: URL, urlSession: URLSessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticateUrl, urlSession: Config.urlSession)
    
    typealias CompletionHandler = (WeatherData?, DataManagerError?) -> Void

    func weatherDataAt(latitude: Double,
                       longitude: Double) -> Observable<WeatherData> {
        
        let url = baseURL.appendingPathComponent("\(latitude),\(longitude)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return (self.urlSession as! URLSession).rx.data(request: request).map { (data) -> WeatherData in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            return try decoder.decode(WeatherData.self, from: data)
        }
    }
}
