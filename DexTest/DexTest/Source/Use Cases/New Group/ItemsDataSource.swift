//
//  ItemsDataSource.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation
import RxSwift

protocol ItemsDataSource {
    func loadItems(limit: Int, offset: Int) -> Single<[Item]>
    func loadItemDetail(index: Int) -> Single<ItemDetail>
}
