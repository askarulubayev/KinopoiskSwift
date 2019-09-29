//
//  ListItemsPersonPresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class ListItemsPersonPresenter: ListItemsPresenterProtocol {
    
    typealias ItemModelType = Person
    
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
}
