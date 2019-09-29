//
//  ItemDetailsViewContronller.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/23/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ItemDetailsViewContronller: BaseTableViewController {
    
    var presenter: ItemDetailsPresenterInput?
    var router: ItemDetailsRouterInput?
    
    private let headerView = ItemDetailsHeaderView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 182))
    
    private var headerComponents = [ItemDetailHeaderComponent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeViews()
        
        presenter?.loadDetails()
    }
}

extension ItemDetailsViewContronller: ItemDetailsViewInput {
    func set(headerModel: TmdbDetailsModel) {
        headerView.set(model: headerModel)
    }
    
    func set(headerComponents: [ItemDetailHeaderComponent]) {
        self.headerComponents = headerComponents
        tableView.reloadData()
    }
}

extension ItemDetailsViewContronller {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerComponents.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerComponents[section].components.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView: SectionHeaderView = tableView.dequeueReusableHeaderFooter()
        switch headerComponents[section].headerComponent {
        case .emptyHeader:
            return UIView()
        case .headerWith(let title):
            sectionView.set(title: title)
        }
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = headerComponents[indexPath.section].components[indexPath.row]
        switch component {
        case .overview(let text):
            let cell: ItemDetailsOverviewTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(overview: text)
            return cell
        case .images(let imageUrlStrings):
            let cell: ItemDetailsImagesTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(imageUrlStrings: imageUrlStrings)
            return cell
        case .model(let model):
            let cell: ListItemTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(model: model)
            return cell
        case .showAll(let models):
            let cell: ShowAllItemsTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(title: "Показать все (" + models.count.description + ")")
            return cell
        case .spacer:
            let cell: SpacerTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.didSelect(component: headerComponents[indexPath.section].components[indexPath.row])
    }
}

extension ItemDetailsViewContronller {
    private func stylizeViews() {
        tableView.tableHeaderView = headerView
        tableView.register(SpacerTVCell.self)
        tableView.register(ItemDetailsOverviewTVCell.self)
        tableView.register(ItemDetailsImagesTVCell.self)
        tableView.register(ListItemTVCell.self)
        tableView.register(ShowAllItemsTVCell.self)
        tableView.register(SectionHeaderView.self)
        tableView.backgroundColor = AppColor.whitish.uiColor
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 1
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
}
