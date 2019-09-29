//
//  MovieDetailNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class MovieDetailNetworkContext: NetworkContext {
    
    let route: TmdbRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(id: Int) {
        route = .getMovieDetail(id: id)
    }
}
