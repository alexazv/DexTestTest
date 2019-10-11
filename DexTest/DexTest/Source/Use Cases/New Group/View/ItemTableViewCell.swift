//
//  ItemTableViewCell.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgSprite: UIImageView!

    override func prepareForReuse() {
      super.prepareForReuse()
        lbName.text = "..."
        imgSprite.image = nil
        lbIndex.text = ""
    }
    
    func update(with model: ItemViewModel) {
        lbIndex.text = "#\(model.index)"
        lbName.text = model.name

        if let url = model.image {
            imgSprite.af_setImage(withURL: url)
        } else {
            imgSprite.image = nil
        }
    }
}
