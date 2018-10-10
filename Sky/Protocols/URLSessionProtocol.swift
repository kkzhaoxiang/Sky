//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation

typealias DataTaskHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol
}
