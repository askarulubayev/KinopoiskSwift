//
//  SearchResultRouter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/2/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class SearchResultRouter {
    
    private weak var viewController: SearchResultViewInput?
    private let navigationController: NavigationController
    private let networkService: NetworkService
    private let query: String
    
    init(query: String, navigationController: NavigationController, networkService: NetworkService) {
        self.query = query
        self.navigationController = navigationController
        self.networkService = networkService
        
        let viewController = SearchResultViewController()
        self.viewController = viewController
        
        let presenter = SearchResultPresenter(view: viewController, networkService: networkService, query: query)
        
        viewController.presenter = presenter
        viewController.router = self
        viewController.title = "Поиск \"" + query + "\""
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SearchResultRouter: SearchResultRouterInput {
    func routeToListPage(modelType: TmdbModelType) {
        let _ = ListItemsRouter(
            tmdbSearchPageableListType: modelType.searchType,
            searchText: query,
            navigationController: navigationController,
            networkService: networkService
        )
    }
    
    func routeToDetailPage(model: TmdbModel) {
        _ = ItemDetailsRouter(model: model, navigationController: navigationController, networkService: networkService)
    }
}
