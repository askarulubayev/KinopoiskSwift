//
//  PersonMovieCreditsNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/11/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class PersonMovieCreditsNetworkContext: NetworkContext {
    
    let route: TmdbRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(id: Int) {
        route = .getPersonMovieCredits(id: id)
    }
}
