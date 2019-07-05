//
//  MainPageRouterInput.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol MainPageRouterInput: class {
    func routeToListPage(listType: TmdbPageableListType)
    func routeToSearchPage(query: String)
}
