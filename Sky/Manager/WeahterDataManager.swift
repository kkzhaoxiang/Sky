//
//  WeahterDataManager.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation

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
    
    static let shared = WeatherDataManager(baseURL: API.authenticateUrl, urlSession: URLSession.shared)
    
    typealias CompletionHandler = (WeatherData?, DataManagerError?) -> Void

    func weatherDataAt(latitude: Double,
                       longitude: Double,
                       completion: @escaping CompletionHandler) {
        
        let url = baseURL.appendingPathComponent("\(latitude),\(longitude)")
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        self.urlSession.dataTask(with: request) { (data, response, error) in
            self.didFinishGettingWeatherData(
                data: data,
                response: response,
                error: error,
                completion: completion)
        }.resume()
    }
    
    func didFinishGettingWeatherData(
            data: Data?, response:
            URLResponse?,
            error: Error?,
            completion: CompletionHandler)  {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data,
            let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let decode = JSONDecoder()
                    decode.dateDecodingStrategy = .secondsSince1970
                    let weatherData = try decode.decode(WeatherData.self, from: data)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknow)
        }
    }
}
