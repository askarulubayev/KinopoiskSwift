//
//  ListItemsPersonPresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class ListItemsPersonPresenter: ListItemsPresenterProtocol {
    
    private weak var itemsView: ListItemsViewInput!
    
    var view: ListItemsViewInput {
        return itemsView
    }
    var tmdbPageableListType: TmdbPageableListType?
    var tmdbSearchPageableListType: TmdbSearchPageableListType?
    var searchText: String?
    var networkService: NetworkService
    var models = [TmdbModel]()
    
    required init(view: ListItemsViewInput, tmdbPageableListType: TmdbPageableListType, networkService: NetworkService) {
        self.itemsView = view
        self.tmdbPageableListType = tmdbPageableListType
        self.networkService = networkService
    }
    
    required init(view: ListItemsViewInput, tmdbSearchPageableListType: TmdbSearchPageableListType, searchText: String, networkService: NetworkService) {
        self.itemsView = view
        self.tmdbSearchPageableListType = tmdbSearchPageableListType
        self.searchText = searchText
        self.networkService = networkService
    }
    
    func loadItems(page: Int) {
        if tmdbPageableListType != nil {
            loadItems(page: page, type: Person.self)
        } else if tmdbSearchPageableListType != nil {
            searchItems(page: page, type: Person.self)
        }
    }
}
