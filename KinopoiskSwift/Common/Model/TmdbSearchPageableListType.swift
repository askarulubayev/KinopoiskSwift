//
//  TmdbSearchPageableListType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/2/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum TmdbSearchPageableListType {
    
    case searchMovie
    case searchTV
    case searchPerson
    case searchMulti
    
    func getNetworkContext(query: String, page: Int) -> NetworkContext {
        switch self {
        case .searchMovie:
            return MovieSearchNetworkContext(query: query, page: page)
        case .searchTV:
            return TVSearchNetworkContext(query: query, page: page)
        case .searchPerson:
            return PersonSearchNetworkContext(query: query, page: page)
        case .searchMulti:
            return MultiSearchNetworkContext(query: query, page: page)
        }
    }
    
    var modelType: TmdbModelType? {
        switch self {
        case .searchMovie:
            return .movie
        case .searchTV:
            return .tv
        case .searchPerson:
            return .person
        case .searchMulti:
            return .none
        }
    }
}
