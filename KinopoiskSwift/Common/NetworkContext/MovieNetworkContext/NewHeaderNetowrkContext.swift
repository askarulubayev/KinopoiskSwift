//
//  NewHeaderNetowrkContext.swift
//  KinopoiskSwift
//
//  Created by Askar on 7/21/20.
//  Copyright © 2020 askar.ulubayev. All rights reserved.
//

class NewHeaderNetowrkContext: NetworkContext {
    
    let route: TmdbRoute = .newHeader
    let method: NetworkMethod = .get
    var parameters = [String: Any]()
    
    init(page: Int) {
        parameters["page"] = page
    }
}
