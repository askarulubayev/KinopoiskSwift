//
//  SearchResultViewController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/2/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SearchResultViewController: BaseTableViewController {
    
    var presenter: SearchResultPresenterInput?
    var router: SearchResultRouterInput?
    
    var headerComponents = [SearchResultHeaderComponent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeViews()
        presenter?.loadComponents()
    }
}

extension SearchResultViewController: SearchResultViewInput {
    func set(headerComponents: [SearchResultHeaderComponent]) {
        self.headerComponents = headerComponents
        tableView.reloadData()
    }
}

extension SearchResultViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerComponents.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView: SectionHeaderView = tableView.dequeueReusableHeaderFooter()
        sectionView.set(title: headerComponents[section].sectionTitle)
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerComponents[section].components.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = headerComponents[indexPath.section].components[indexPath.row]
        switch component {
        case .component(let model):
            let cell: ListItemTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(model: model)
            return cell
        case .allResult(let type, let totalResult):
            let cell: ShowAllItemsTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(title: type.title + " (" + totalResult.description + ")")
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let component = headerComponents[indexPath.section].components[indexPath.row]
        switch component {
        case .component(let model):
            print(model.id as Any)
        case .allResult(let type, _):
            router?.routeToListPage(modelType: type)
        }
    }
}

extension SearchResultViewController {
    private func stylizeViews() {
        tableView.register(ListItemTVCell.self)
        tableView.register(ShowAllItemsTVCell.self)
        tableView.register(SectionHeaderView.self)
        tableView.backgroundColor = AppColor.lightGray.uiColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}
