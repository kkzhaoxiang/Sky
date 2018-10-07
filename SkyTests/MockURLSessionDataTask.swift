//
//  MockURLSessionDataTask.swift
//  SkyTests
//
//  Created by 王兆祥 on 2018/10/7.
//  Copyright © 2018 王兆祥. All rights reserved.
//

import Foundation

@testable import Sky

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var isResumeCalled = false
   
    func resume() {
        self.isResumeCalled = true
    }
}
