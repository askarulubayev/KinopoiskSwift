//
//  TmdbModelType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum TmdbModelType: String, Decodable {
    case person
    case movie
    case tv
    
    var title: String {
        switch self {
        case .person:
            return "Люди"
        case .movie:
            return "Фильмы"
        case .tv:
            return "ТВ-шоу"
        }
    }
    
    var metatype: TmdbModel.Type {
        switch self {
        case .person:
            return Person.self
        case .tv:
            return TVShow.self
        case .movie:
            return Movie.self
        }
    }
    
    var searchType: TmdbSearchPageableListType {
        switch self {
        case .movie:
            return .searchMovie
        case .tv:
            return .searchTV
        case .person:
            return .searchPerson
        }
    }
}
