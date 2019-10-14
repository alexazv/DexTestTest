//
//  ItemStatCollectionViewCell.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import UIKit

class ItemStatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbValue: UILabel!
    @IBOutlet weak var lbIndex: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(name: String, value: Int) {
        lbValue.text = "\(value)"
        lbIndex.text = name
    }
}
