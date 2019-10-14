//
//  DepInjection.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

class DepInjection {
    static var mockData = false

    static var itemsDataSource: ItemsDataSource {
        return mockData ? ItemsLocalRepository() : ItemsRepository()
    }

}
