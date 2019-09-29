//
//  SimilarMoviesNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/10/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class SimilarMoviesNetworkContext: NetworkContext {
    let route: TmdbRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(id: Int, page: Int = 1) {
        route = .getMoviesSimilar(id: id)
        parameters["page"] = page
    }
}
