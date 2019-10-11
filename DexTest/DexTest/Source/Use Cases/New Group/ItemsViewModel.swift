//
//  ItemsViewModel.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

struct ItemsViewModel {
    let items: [ItemViewModel]
    let showPreviousPage: Bool
    let showNextPage: Bool
}

struct ItemViewModel {
    let index: Int
    let name: String
    let image: URL?
}
