//
//  MediaType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum MediaType: String, Codable {
    case person
    case tv
    case movie
    
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
}
