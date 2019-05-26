//
//  TmdbModelType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum TmdbModelType {
    case actor
    case movie
    case tvShow
    
    var title: String {
        switch self {
        case .actor:
            return "Люди"
        case .movie:
            return "Фильмы"
        case .tvShow:
            return "ТВ-шоу"
        }
    }
}
