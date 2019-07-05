//
//  TVGenresNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/23/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class TVGenresNetworkContext: NetworkContext {
    var route: TmdbRoute = .getTVGenres
    var method: NetworkMethod = .get
    var parameters = [String: Any]()
}
