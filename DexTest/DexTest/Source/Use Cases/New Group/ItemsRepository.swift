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

struct DetailResponse: Codable {
    let name: String
    let stats: [StatResponse]
    let sprites: [String: String?]

    struct StatResponse: Codable {
        let baseStat: Int
        let stat: StatDetail

        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }
    }

    struct StatDetail: Codable {
        let name: String
    }
}

class ItemsRepository: ItemsDataSource {

    private func fetchFromCache(limit: Int, offset: Int) -> [Item] {
        var items: [Item] = []
        for index in offset..<offset+limit {
            if let object = ItemCache.item(forKey: "\(index+1)") as? Item {
                items.append(object)
            } else {
                items.append(Item(index: index+1, name: "..."))
            }
        }
        return items
    }

    private func fetchDetailFromCache(index: Int) -> ItemDetail? {
        return ItemCache.item(forKey: "detail-\(index)") as? ItemDetail
    }

    func loadItemDetail(index: Int) -> Single<ItemDetail> {
        return Single.create { observer in
            let disposable = Disposables.create {}

            if !(NetworkReachabilityManager()?.isReachable ?? false) {
                if let object = self.fetchDetailFromCache(index: index) {
                    observer(.success(object))
                } else {
                    observer(.error(NSError(domain: "", code: NSURLErrorTimedOut)))
                }
                return disposable
            }

            Alamofire.request("https://pokeapi.co/api/v2/pokemon/\(index)/").responseData { jsonResponse in
                let decoder = JSONDecoder()

                switch jsonResponse.result {
                case .success:

                    do {
                        let response = try decoder.decode(DetailResponse.self, from: jsonResponse.data ?? Data())

                        var stats: [Stat: Int] = [:]

                        for statDetail in response.stats {
                            if let stat = Stat(rawValue: statDetail.stat.name) {
                                stats[stat] = statDetail.baseStat
                            }
                        }

                        let item = ItemDetail(name: response.name,
                                              stats: stats,
                                              sprites: response.sprites.values.compactMap({$0}))

                        ItemCache.setItem(item, forKey: "detail-\(index)")
                        observer(.success(item))
                    } catch {
                        observer(.error(error))
                    }
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut, let cached = self.fetchDetailFromCache(index: index) {
                        observer(.success(cached))
                    } else {
                        observer(.error(error))
                    }
                }
            }

            return disposable
        }
    }

    func loadItems(limit: Int, offset: Int) -> Single<[Item]> {
        return Single.create { observer in
            let disposable = Disposables.create {}

            if !(NetworkReachabilityManager()?.isReachable ?? false) {
                observer(.success(self.fetchFromCache(limit: limit, offset: offset)))
                return disposable
            }

            Alamofire.request("https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)").responseData { jsonResponse in
                let decoder = JSONDecoder()

                switch jsonResponse.result {
                case .success:
                    var items: [Item] = []

                    do {
                        let response = try decoder.decode(Response.self, from: jsonResponse.data ?? Data())

                            for element in response.results.enumerated() {
                                let item = Item(index: offset + element.offset + 1, name: element.element.name)
                                ItemCache.setItem(item, forKey: "\(item.index)")
                                items.append(item)
                            }
                        observer(.success(items))
                    } catch {
                        observer(.error(error))
                    }
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        observer(.success(self.fetchFromCache(limit: limit, offset: offset)))
                    } else {
                        observer(.error(error))
                    }
                }
            }

            return disposable
        }
    }
}
