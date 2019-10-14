//
//  ItemDetail.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

enum Stat: String {
    case attack = "attack"
    case defense = "defense"
    case spAtk = "special-attack"
    case spDef = "special-defense"
    case speed = "speed"
}

class ItemDetail {
    var name: String
    var stats: [Stat: Int]
    var sprites: [String]

    init(name: String, stats: [Stat: Int], sprites: [String]) {
        self.name = name
        self.stats = stats
        self.sprites = sprites
    }
}
