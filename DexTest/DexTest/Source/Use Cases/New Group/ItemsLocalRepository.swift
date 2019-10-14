//
//  ItemsLocalRepository.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation
import RxSwift

class ItemsLocalRepository: ItemsDataSource {
    func loadItemDetail(index: Int) -> Single<ItemDetail> {
        return .just(ItemDetail(name: "", stats: [:], sprites: []))
    }

    func loadItems(limit: Int, offset: Int) -> Single<[Item]> {

        guard let path = Bundle.main.path(forResource: "Items", ofType: "json") else {
            return .error(NSError.init(domain: "Not found", code: 404))
        }

        return Single.create { observer in
            let disposable = Disposables.create {}

            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                var items: [Item] = []
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let response = try decoder.decode(Response.self, from: data)
                    for element in response.results[min(offset, response.results.count)..<min(offset+limit, response.results.count)].enumerated() {
                        let item = Item(index: offset + element.offset + 1, name: element.element.name)
                        ItemCache.setItem(item, forKey: "\(item.index)")
                        items.append(item)
                    }
                    observer(.success(items))

                } catch {
                    observer(.error(error))
                }
            }

            return disposable
        }
    }
}
