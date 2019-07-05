//
//  SearchResultComponentType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/22/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum SearchResultComponentType {
    case component(model: TmdbModel)
    case allResult(type: TmdbModelType, totalResult: Int)
}
