//
//  ItemDetailtest.swift
//  DexTestTests
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import XCTest
@testable import DexTest

class ItemDetailtest: XCTestCase {

    var presenter: ItemDetailPresenter!

    override func setUp() {
        presenter = ItemDetailPresenter(index: 1)
        super.setUp()
    }

    func testFetchData() {
        let expectation = self.expectation(description: "FetchData")

        var item: ItemDetail!

        presenter.loadData { data in
            item = data
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertGreaterThan(item.sprites.count, 1)
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }

}
