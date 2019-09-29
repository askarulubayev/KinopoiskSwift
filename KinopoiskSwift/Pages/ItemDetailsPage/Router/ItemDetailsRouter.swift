//
//  ItemDetailsRouter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class ItemDetailsRouter {
    
    let model: TmdbModel
    let presneter: ItemDetailsPresenterInput
    let navigationController: NavigationController
    let networkService: NetworkService
    
    private weak var viewController: ItemDetailsViewContronller?
    
    init(
        model: TmdbModel,
        navigationController: NavigationController,
        networkService: NetworkService
    ) {

        self.model = model
        self.navigationController = navigationController
        self.networkService = networkService
        
        let viewController = ItemDetailsViewContronller()
        switch  model.getModelType() {
        case .movie:
            presneter = ItemDetailsMoviePresenter(view: viewController, model: model, networkService: networkService)
        case .tv:
            presneter = ItemDetailsTVPresenter(view: viewController, model: model, networkService: networkService)
        case .person:
            presneter = ItemDetailsPersonPresenter(view: viewController, model: model, networkService: networkService)
        }
        
        viewController.presenter = presneter
        viewController.router = self
        viewController.title = model.getTitle()
        
        self.viewController = viewController
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ItemDetailsRouter: ItemDetailsRouterInput {
    func didSelect(component: ItemDetailComponentType) {
        switch component {
        case .model(let model):
            let _ = ItemDetailsRouter(model: model, navigationController: navigationController, networkService: networkService)
        case .showAll(let models):
            let _ = ListItemsRouter(models: models, navigationController: navigationController, networkService: networkService)
        case .overview(let text):
            let viewController = OverviewPageViewController(overviewText: text)
            viewController.title = model.getTitle()
            navigationController.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
