//
//  ListItemsPresenterProtocol.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

protocol ListItemsPresenterProtocol: class, ListItemsPresenterInput {
    
    associatedtype ItemModelType: TmdbModel
    
    var view: ListItemsViewInput { get }
    var tmdbPageableListType: TmdbPageableListType? { get }
    var tmdbSearchPageableListType: TmdbSearchPageableListType? { get }
    var searchText: String? { get }
    var networkService: NetworkService { get }
    var models: [TmdbModel] { get set }
    
    init(view: ListItemsViewInput, tmdbPageableListType: TmdbPageableListType, networkService: NetworkService)
    
    init(view: ListItemsViewInput, tmdbSearchPageableListType: TmdbSearchPageableListType, searchText: String, networkService: NetworkService)
}

extension ListItemsPresenterProtocol {
    func setTitle() {
        if let listType = tmdbPageableListType {
            view.set(title: listType.title)
        } else if tmdbSearchPageableListType != nil, let searchText = searchText {
            view.set(title: "Поиск \"" + searchText + "\"")
        }
    }
    
    func loadItems(page: Int) {
        if let listType = tmdbPageableListType {
            let networkContext = listType.getNetworkContext(page: page)
            loadDecodableList(networkContext: networkContext)
        } else {
            searchItems(page: page)
        }
    }
    
    func searchItems(page: Int) {
        guard let listType = tmdbSearchPageableListType, let searchText = searchText else { return }
        let networkContext = listType.getNetworkContext(query: searchText, page: page)
        loadDecodableList(networkContext: networkContext)
    }
}

extension ListItemsPresenterProtocol {
    private func loadDecodableList(networkContext: NetworkContext) {
        networkService.loadDecodable(
            context: networkContext,
            type: TmdbResult<ItemModelType>.self
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
