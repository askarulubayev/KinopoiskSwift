//
//  MainPageRouter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class MainPageRouter {
    
    weak private var viewController: MainPageViewInput?
    private let navigationController: NavigationController
    private let networkService: NetworkService
    
    init() {
        networkService = NetworkAdapter()
        
        let viewController = MainPageViewController()
        self.viewController = viewController
        
        let presenter = MainPagePresenter(view: viewController)
        viewController.presenter = presenter
        
        navigationController = NavigationController(rootViewController: viewController)
        viewController.router = self
    }
    
    func createMainPage() -> NavigationController {
        return navigationController
    }
}

extension MainPageRouter: MainPageRouterInput {
    func routeToSearchPage(query: String) {
        _ = SearchResultRouter(query: query, navigationController: navigationController, networkService: networkService)
    }
    
    func routeToListPage(listType: TmdbPageableListType) {
        _ = ListItemsRouter(tmdbPageableListType: listType, navigationController: navigationController, networkService: networkService)
    }
    
    func routeToDetailPage(model: TmdbModel) {
        _ = ItemDetailsRouter(model: model, navigationController: navigationController, networkService: networkService)
    }
}
