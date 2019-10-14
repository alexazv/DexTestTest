//
//  ItemCache.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation

class ItemCache {
    static private let cache = NSCache<NSString, AnyObject>()

    static func item(forKey key: String) -> Any? {
        return cache.object(forKey: key as NSString)
    }

    static func setItem(_ item: AnyObject, forKey key: String) {
        cache.setObject(item, forKey: key as NSString)
    }
}
