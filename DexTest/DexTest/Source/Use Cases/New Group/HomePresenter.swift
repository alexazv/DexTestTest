//
//  HomePresenter.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import Foundation
import RxSwift

class HomePresenter {

    private var offset = 0
    private var limit = 20

    private var dataSource: ItemsDataSource? = ItemsRepository()
    private var bag = DisposeBag()

    weak var view: HomeViewContract?

    func onViewDidLoad() {
        loadData()
    }

    private func loadData() {
        view?.setLoading(to: true)
        dataSource?.loadItems(limit: limit, offset: offset)
            .subscribe(onSuccess: { items in

                let model = ItemsViewModel(items: items.map({
                    ItemViewModel(index: $0.index, name: $0.name, image: URL(string: $0.imageURL))
                    }),
                    showPreviousPage: true,
                    showNextPage: true
                )

                self.view?.update(with: model)
                self.view?.setLoading(to: false)
            }, onError: { error in
                self.view?.setLoading(to: false)
            }).disposed(by: bag)
    }

    func onSelect(number: Int) {

    }

    func onNextPage() {
        offset += limit
        loadData()
    }

    func onPreviousPage() {
        offset = max(offset-limit, 0)
        loadData()
    }
}
