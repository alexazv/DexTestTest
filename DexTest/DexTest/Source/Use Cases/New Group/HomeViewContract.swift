//
//  HomeViewContract.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

protocol HomeViewContract: BaseViewContract {
    func update(with model: ItemsViewModel)
}
