//
//  HomeViewController.swift
//  DexTest
//
//  Created by Alexandre Azevedo on 11/10/19.
//  Copyright © 2019 Ilhasoft. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!

    private var presenter: HomePresenter?
    private var model: ItemsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter = HomePresenter()
        presenter?.view = self
        presenter?.onViewDidLoad()
    }

    @IBAction func didTapBtPrevious(_ sender: Any) {
        presenter?.onPreviousPage()
    }

    @IBAction func didTapBtNext(_ sender: Any) {
        presenter?.onNextPage()
    }

}

extension HomeViewController: HomeViewContract {
    func update(with model: ItemsViewModel) {
        self.model = model
        tableView.reloadData()
    }

    func setLoading(to loading: Bool) {
        loadingView.alpha = loading ? 0.5 : 0
    }

    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        okAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    func navigateToDetails(index: Int) {
        navigationController?.pushViewController(ItemDetailViewController(index: index), animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    private func setupTableView() {
        tableView.register(UINib.init(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        // tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let model = model else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell

        cell?.update(with: model.items[indexPath.row])

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let index = model?.items[indexPath.row].index else { return }
        presenter?.onSelect(number: index)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         guard let index = model?.items[indexPath.row].index else { return }
        presenter?.onSelect(number: index)
    }
}
