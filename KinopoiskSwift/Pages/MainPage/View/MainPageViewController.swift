//
//  MainPageViewController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit
import SkeletonView

class MainPageViewController: BaseTableViewController {
    
    var router: MainPageRouterInput?
    var presenter: MainPagePresenter?
    
    private lazy var searchController = SearchController(searchResultsController: searchResultsController)
    private let searchResultsController = SearchPromptsResultViewController(
        cellIdentier: String(describing: SearchPromptResultTVCell.self),
        cellClass: SearchPromptResultTVCell.self
    )
    
    private let headerView = MainPageHeaderView(
        frame: CGRect(x: 0, y: 0, width: screenSize.width, height: MainPageHeaderViewController.getHeight())
    )
    private var headerComponents = [MainPageHeaderComponent]()
    
    private var searchResult = [TmdbModel]()
    private var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadMainPage()
        stylizeViews()
    }
    
    func showError(message: String, completion: VoidCompletion? = nil) {
        super.showError(message: message)
        refreshControl?.endRefreshing()
    }
}

extension MainPageViewController {
    @objc private func refreshTableView() {
        refreshControl?.beginRefreshing()
        presenter?.refreshMainPage()
    }
    
    @objc private func searchButtonTapped() {
        present(searchController, animated: true) {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}

extension MainPageViewController: MainPageViewInput {
    func set(headerComponents: [MainPageHeaderComponent]) {
        refreshControl?.endRefreshing()
        self.headerComponents = headerComponents
        tableView.reloadData()
    }
    
    func set(upcomingMovies: [Movie]) {
        refreshControl?.endRefreshing()
        headerView.hideLoadingState()
        headerView.set(movies: upcomingMovies)
        tableView.reloadData()
    }
    
    func set(searchResult: [TmdbModel]) {
        self.searchResult = searchResult
        searchResultsController.reloadData()
    }
}

extension MainPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        presenter?.searchMulti(text: searchText)
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchText, !searchText.isEmpty else { return }
        router?.routeToSearchPage(query: searchText)
        searchController.isActive = false
    }
}

extension MainPageViewController: SearchPromptsResultViewDelegate {
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.routeToDetailPage(model: searchResult[indexPath.row])
    }
    
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        
        return 57
    }
}

extension MainPageViewController: SearchPromptsResultViewDataSource {
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        return searchResult.count
    }
    
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: SearchPromptResultTVCell.self),
            for: indexPath
        ) as! SearchPromptResultTVCell
        
        cell.set(model: searchResult[indexPath.row])
        return cell
    }
}

extension MainPageViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerComponents.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerComponents[section].components.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = headerComponents[indexPath.section].components[indexPath.row]
        switch component {
        case .showAllItemsWithBigTitle(let type), .showAllItems(let type):
            let cell: ShowAllItemsTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(title: type.title)
            cell.hideLoadingState()
            switch component {
            case .showAllItemsWithBigTitle:
                cell.makeBigTitle()
                cell.hideSeparatorView()
                cell.selectionStyle = .none
            default:
                cell.makeSmallTitle()
                let isLastElement = indexPath.row == headerComponents[indexPath.section].components.count - 1
                isLastElement ? cell.hideSeparatorView() : cell.showSeparatorView()
                cell.selectionStyle = .default
            }
            return cell
        case .horizontalListItems(let models):
            let cell: HorizontalListItemsTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            addChild(cell.viewController)
            cell.set(models: models)
            cell.hideLoadingState()
            return cell
        case .showAllItemsSkeleton:
            let cell: ShowAllItemsTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.showLoadingState()
            let isLastElement = indexPath.row == headerComponents[indexPath.section].components.count - 1
            isLastElement ? cell.hideSeparatorView() : cell.showSeparatorView()
            cell.selectionStyle = .none
            return cell
        case .horizontalListItemsSkeleton:
            let cell: HorizontalListItemsTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            addChild(cell.viewController)
            cell.showLoadingState()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView: SectionHeaderView = tableView.dequeueReusableHeaderFooter()
        sectionView.set(title: headerComponents[section].sectionTitle)
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let component = headerComponents[indexPath.section].components[indexPath.row]
        switch component {
        case .horizontalListItems:
            break
        case .showAllItems(let listType):
            router?.routeToListPage(listType: listType)
        case .showAllItemsWithBigTitle(let listType):
            router?.routeToListPage(listType: listType)
        default:
            break
        }
    }
}

extension MainPageViewController {
    private func stylizeViews() {
        title = "ColdFilm"
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        UISearchBar.appearance().tintColor = AppColor.darkGray.uiColor
        
        searchResultsController.delegate = self
        searchResultsController.dataSource = self
        
        navigationItem.searchController = nil
        
        addChild(headerView.headerViewController)
        tableView.tableHeaderView = headerView
        tableView.register(SectionHeaderView.self)
        tableView.register(HorizontalListItemsTVCell.self)
        tableView.register(ShowAllItemsTVCell.self)
        tableView.backgroundColor = AppColor.whitish.uiColor
        tableView.contentInset.bottom = 24
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        headerView.showLoadingState()
        
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: AppImage.search.uiImage?.resized(to: CGSize(width: 21, height: 21)),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
    }
}
