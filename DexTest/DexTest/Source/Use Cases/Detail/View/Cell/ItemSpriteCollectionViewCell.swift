//
//  ItemSpriteCollectionViewCell.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemSpriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!

    func update(with imageURL: URL) {
        imgView.af_setImage(withURL: imageURL)
    }
}
