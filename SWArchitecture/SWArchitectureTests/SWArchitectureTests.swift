//
//  SWArchitectureTests.swift
//  SWArchitectureTests
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import XCTest
@testable import SWArchitecture

class SWArchitectureTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        hotkey()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension SWArchitectureTests {
    func hotkey() {
        let _ = HotkeyModel.init(id: "1", hotkey: "o", function: "赋值")
    }
}
