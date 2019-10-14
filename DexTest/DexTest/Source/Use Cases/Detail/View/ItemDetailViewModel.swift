//
//  ItemDetailViewModel.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

struct ItemDetailViewModel {
    var index: Int
    var name: String
    var sprites: [URL]
    var stats: [Stat: Int]
}
