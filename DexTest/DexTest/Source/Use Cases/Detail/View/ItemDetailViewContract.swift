//
//  ItemDetailViewContract.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

protocol ItemDetailViewContract: BaseViewContract {
    func update(with model: ItemDetailViewModel)
}
