//
//  ItemsRepository.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct Response: Codable {

    let results: [ItemResponse]

    struct ItemResponse: Codable {
        let name: String
    }
}



class ItemsRepository: ItemsDataSource {
    func loadItems(limit: Int, offset: Int) -> Single<[Item]> {
        return Single.create { observer in
            let disposable = Disposables.create {}

            Alamofire.request("https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)").responseData { jsonResponse in
                let decoder = JSONDecoder()


                if let error = jsonResponse.error {
                    observer(.error(error))
                    return
                }

                var items: [Item] = []

                do {
                    let response = try decoder.decode(Response.self, from: jsonResponse.data ?? Data())

                                  for element in response.results.enumerated() {
                                                                        items.append(
                                                                            Item(index: offset + element.offset + 1, name: element.element.name)
                                                                        )
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
