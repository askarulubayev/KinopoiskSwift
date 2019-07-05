//
//  ListItemsRouter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class ListItemsRouter<ListItemsPresenter: ListItemsPresenterProtocol>: ListItemsRouterInput {
    
    weak private var viewController: ListItemsViewInput?
    private var tmdbPageableListType: TmdbPageableListType?
    private var tmdbSearchPageableListType: TmdbSearchPageableListType?
    private var searchText: String?
    private let navigationController: NavigationController
    private let networkService: NetworkService
    
    init(
        tmdbPageableListType: TmdbPageableListType,
        navigationController: NavigationController,
        networkService: NetworkService
    ) {
        self.tmdbPageableListType = tmdbPageableListType
        self.navigationController = navigationController
        self.networkService = networkService
        
        let viewController = ListItemsViewController()
        self.viewController = viewController
        
        let presenter = ListItemsPresenter(view: viewController, tmdbPageableListType: tmdbPageableListType, networkService: networkService)
        
        viewController.presenter = presenter
        viewController.router = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    init(
        tmdbSearchPageableListType: TmdbSearchPageableListType,
        searchText: String,
        navigationController: NavigationController,
        networkService: NetworkService
    ) {
        self.tmdbSearchPageableListType = tmdbSearchPageableListType
        self.navigationController = navigationController
        self.networkService = networkService
        self.searchText = searchText
        
        let viewController = ListItemsViewController()
        self.viewController = viewController
        
        let presenter = ListItemsPresenter(
            view: viewController,
            tmdbSearchPageableListType: tmdbSearchPageableListType,
            searchText: searchText,
            networkService: networkService
        )
        
        viewController.presenter = presenter
        viewController.router = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeToDetailPage(model: TmdbModel) {
        let detailViewController = ItemDetailViewContronller(model: model)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
