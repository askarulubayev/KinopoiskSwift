//
//  ListItemsRouter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class ListItemsRouter: ListItemsRouterInput {
    
    weak private var viewController: ListItemsViewInput?
    
    private var tmdbPageableListType: TmdbPageableListType?
    private var tmdbSearchPageableListType: TmdbSearchPageableListType?
    private var searchText: String?
    private let navigationController: NavigationController
    private let networkService: NetworkService
    
    init(
        models: [TmdbModel],
        navigationController: NavigationController,
        networkService: NetworkService
    ) {
        self.navigationController = navigationController
        self.networkService = networkService
        let viewController = ListItemsViewController()
        self.viewController = viewController
        viewController.set(models: models)
        viewController.router = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
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
        
        let presenter: ListItemsPresenterInput
        switch tmdbPageableListType.modelType {
        case .movie:
            presenter = ListItemsMoviePresenter(view: viewController, tmdbPageableListType: tmdbPageableListType, networkService: networkService)
        case .tv:
            presenter = ListItemsTVPresenter(view: viewController, tmdbPageableListType: tmdbPageableListType, networkService: networkService)
        case .person:
            presenter = ListItemsPersonPresenter(view: viewController, tmdbPageableListType: tmdbPageableListType, networkService: networkService)
        }
        
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
        
        let presenter: ListItemsPresenterInput
        switch tmdbSearchPageableListType.modelType! {
        case .movie:
            presenter = ListItemsMoviePresenter(
                view: viewController,
                tmdbSearchPageableListType: tmdbSearchPageableListType,
                searchText: searchText,
                networkService: networkService
            )
        case .tv:
            presenter = ListItemsTVPresenter(
                view: viewController,
                tmdbSearchPageableListType: tmdbSearchPageableListType,
                searchText: searchText,
                networkService: networkService
            )
        case .person:
            presenter = ListItemsPersonPresenter(
                view: viewController,
                tmdbSearchPageableListType: tmdbSearchPageableListType,
                searchText: searchText,
                networkService: networkService
            )
        }
        
        viewController.presenter = presenter
        viewController.router = self
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeToDetailPage(model: TmdbModel) {
        let _ = ItemDetailsRouter(model: model, navigationController: navigationController, networkService: networkService)
    }
}
