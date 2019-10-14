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

    private(set) var offset = 0
    private(set) var limit = 20

    private var dataSource: ItemsDataSource? = DepInjection.itemsDataSource
    private var bag = DisposeBag()

    weak var view: HomeViewContract?

    func onViewDidLoad() {
        loadData()
    }

    private func loadData() {
        fetchData { items in
            let model = ItemsViewModel(items: items.map({
                ItemViewModel(index: $0.index, name: $0.name, image: URL(string: $0.imageURL))
                }),
                showPreviousPage: true,
                showNextPage: true
            )

            self.view?.update(with: model)
        }
    }

    func fetchData(onCompletion: @escaping ([Item]) -> Void) {
        view?.setLoading(to: true)
        dataSource?.loadItems(limit: limit, offset: offset)
            .subscribe(onSuccess: { items in
                onCompletion(items)
                self.view?.setLoading(to: false)
            }, onError: { error in
                self.view?.setLoading(to: false)
                self.view?.showError(error.localizedDescription)
            }).disposed(by: bag)
    }

    func onSelect(number: Int) {
        view?.navigateToDetails(index: number)
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
