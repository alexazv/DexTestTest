//
//  ItemDetailPresenter.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 14/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation
import RxSwift

class ItemDetailPresenter {
    weak var view: ItemDetailViewContract?
    private var index: Int
    private var bag = DisposeBag()

    private var dataSource: ItemsDataSource? = DepInjection.itemsDataSource

    init(index: Int) {
        self.index = index
    }

    func onViewDidLoad() {
        loadData() { item in
            self.view?.update(with: ItemDetailViewModel(index: self.index,
                                                   name: item.name,
                                                   sprites: item.sprites.compactMap({URL(string: $0)}),
                                                   stats: item.stats))
        }
    }

    func loadData(onCompletion: @escaping (ItemDetail) -> Void) {
        view?.setLoading(to: true)
        dataSource?.loadItemDetail(index: index)
            .subscribe(onSuccess: { item in
                onCompletion(item)
                self.view?.setLoading(to: false)
            }, onError: { error in
                self.view?.setLoading(to: false)
                self.view?.showError(error.localizedDescription)
            }).disposed(by: bag)
    }


}
