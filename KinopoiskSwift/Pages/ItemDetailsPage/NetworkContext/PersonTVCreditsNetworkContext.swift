//
//  PersonTVCreditsNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/11/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class PersonTVCreditsNetworkContext: NetworkContext {
    
    let route: TmdbRoute
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(id: Int) {
        route = .getPersonTVCredits(id: id)
    }
}
