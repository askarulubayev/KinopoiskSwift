//
//  TestMovieNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Askar on 7/21/20.
//  Copyright © 2020 askar.ulubayev. All rights reserved.
//

class TestMovieNetworkContext: NetworkContext {
    
    let route: TmdbRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(route: TmdbRoute, page: Int) {
        self.route = route
        parameters["page"] = page
    }
}
