//
//  MovieGenresNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/23/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class MovieGenresNetworkContext: NetworkContext {
    var route: TmdbRoute = .getMovieGenres
    var method: NetworkMethod = .get
    var parameters = [String: Any]()
}
