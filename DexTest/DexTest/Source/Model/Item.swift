//
//  Item.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

class Item {
    let index: Int
    let name: String

    init(index: Int, name: String) {
        self.index = index
        self.name = name
    }

    var imageURL: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(index).png"
    }
}
