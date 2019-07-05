//
//  MovieSearchNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/2/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class MovieSearchNetworkContext: NetworkContext {
    var route: TmdbRoute { return .searchMovie }
    var method: NetworkMethod { return .get }
    var parameters = [String: Any]()
    
    init(query: String, page: Int) {
        parameters["query"] = query
        parameters["page"] = page
    }
}

