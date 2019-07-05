//
//  UpcomingMoviesNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/22/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class UpcomingMoviesNetworkContext: NetworkContext {
    var route: TmdbRoute { return .getMoviesUpcoming }
    var method: NetworkMethod { return .get }
    var parameters = [String: Any]()
    
    init(page: Int) {
        parameters["page"] = page
    }
}
