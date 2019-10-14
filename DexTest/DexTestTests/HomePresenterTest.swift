//
//  HomePresenterTest.swift
//  DexTestTests
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import XCTest
@testable import DexTest

class HomePresenterTest: XCTestCase {

    var presenter: HomePresenter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DepInjection.mockData = true
        presenter = HomePresenter()
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        DepInjection.mockData = false
        presenter = nil
        super.tearDown()
    }

    func testFetchData() {

       let expectation = self.expectation(description: "FetchData")

        var items = [Item]()

        presenter.fetchData { data in
            items = data
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(items.count, presenter.limit)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
