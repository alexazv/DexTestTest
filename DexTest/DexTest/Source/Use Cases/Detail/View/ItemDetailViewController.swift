//
//  ItemDetailViewController.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private var model: ItemDetailViewModel?

    var presenter: ItemDetailPresenter?

    init(index: Int) {
        presenter = ItemDetailPresenter(index: index)
        super.init(nibName: "ItemDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter?.view = self
        presenter?.onViewDidLoad()
    }
}

extension ItemDetailViewController: ItemDetailViewContract {
    func update(with model: ItemDetailViewModel) {
        self.model = model
        lbName.text = model.name
        lbIndex.text = "#\(model.index)"
        collectionView.reloadData()
    }

    func setLoading(to loading: Bool) {

    }

    func showError(_ message: String) {

    }
}

extension ItemDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ItemSpriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemSpriteCollectionViewCell")
        collectionView.register(UINib(nibName: "ItemStatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemStatCollectionViewCell")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 100, height: 100)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 100)
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return model?.sprites.count ?? 0
        case 1:
            return model?.stats.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let model = self.model else { return UICollectionViewCell() }

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSpriteCollectionViewCell",
                                                          for: indexPath) as? ItemSpriteCollectionViewCell
            cell?.update(with: model.sprites[indexPath.row])
            return cell ?? UICollectionViewCell()
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemStatCollectionViewCell",
                                                          for: indexPath) as? ItemStatCollectionViewCell
            let stat = Array(model.stats.keys)[indexPath.row]

            cell?.update(name: stat.rawValue, value: model.stats[stat] ?? 0)
            return cell ?? UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
}
