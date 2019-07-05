//
//  ListItemsViewController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ListItemsViewController: BaseTableViewController {
    
    var presenter: ListItemsPresenterInput?
    var router: ListItemsRouterInput?
    
    private let footerView = SpinnerFooterView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
    
    private var models = [TmdbModel]()
    private var page = 1
    private var maxResult = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeViews()
        presenter?.setTitle()
        presenter?.loadItems(page: page)
    }
}

extension ListItemsViewController: ListItemsViewInput {
    func set(title: String) {
        self.title = title
    }
    
    func set(models: [TmdbModel]) {
        footerView.hideSpinner()
        self.models = models
        tableView.reloadData()
    }
    
    func set(maxResult: Int) {
        self.maxResult = maxResult
    }
}

extension ListItemsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListItemTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.set(model: models[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isMaxNumberOfItems = models.count == maxResult
        let isLastElement = indexPath.row == models.count - 1
        let isThereInternetConnection = maxResult != -1
        if !isMaxNumberOfItems && isLastElement && isThereInternetConnection {
            footerView.showSpinner()
            page += 1
            presenter?.loadItems(page: page)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToDetailPage(model: models[indexPath.row])
    }
}

extension ListItemsViewController {
    private func stylizeViews() {
        tableView.register(ListItemTVCell.self)
        tableView.backgroundColor = AppColor.lightGray.uiColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = footerView
        tableView.contentInset.top = 6
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}
