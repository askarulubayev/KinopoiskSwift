//
//  ListItemsPresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/26/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class ListItemsPresenter {
    
    weak var view: ListItemsViewInput!
    
    private let networkService = NetworkAdapter()
    
    private var listType: TmdbPageableListType
    
    private var models = [TmdbModel]()
    
    init(view: ListItemsViewInput, listType: TmdbPageableListType) {
        self.view = view
        self.listType = listType
    }
}

extension ListItemsPresenter: ListItemsPresenterInput {
    func loadItems(page: Int) {
        let networkContext = listType.getNetworkContext(page: page)
        switch listType.modelType {
        case .actor:
            networkService.loadDecodable(
                context: networkContext,
                type: TmdbResult<Person>.self
            ) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let tmdbResult):
                    if let results = tmdbResult.results, !results.isEmpty {
                        strongSelf.models += results
                        strongSelf.view.set(models: strongSelf.models)
                        strongSelf.view.set(maxResult: tmdbResult.total_results ?? -1)
                    }
                case .error(let error):
                    strongSelf.view.showError(message: error.description)
                }
            }
        case .movie:
            networkService.loadDecodable(
                context: networkContext,
                type: TmdbResult<Movie>.self
            ) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let tmdbResult):
                    if let results = tmdbResult.results, !results.isEmpty {
                        strongSelf.models += results
                        strongSelf.view.set(models: strongSelf.models)
                        strongSelf.view.set(maxResult: tmdbResult.total_results ?? -1)
                    }
                case .error(let error):
                    strongSelf.view.showError(message: error.description)
                }
            }
        case .tvShow:
            networkService.loadDecodable(
                context: networkContext,
                type: TmdbResult<TVShow>.self
            ) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let tmdbResult):
                    if let results = tmdbResult.results, !results.isEmpty {
                        strongSelf.models += results
                        strongSelf.view.set(models: strongSelf.models)
                        strongSelf.view.set(maxResult: tmdbResult.total_results ?? -1)
                    }
                case .error(let error):
                    strongSelf.view.showError(message: error.description)
                }
            }
        }
    }
    
    private func sww() {
        
    }
}
