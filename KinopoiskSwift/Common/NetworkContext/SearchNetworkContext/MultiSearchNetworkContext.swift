//
//  MultiSearchNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/30/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class MultiSearchNetworkContext: NetworkContext {
    var route: TmdbRoute { return .searchMulti }
    var method: NetworkMethod { return .get }
    var parameters = [String: Any]()
    
    init(query: String, page: Int) {
        parameters["query"] = query
        parameters["page"] = page
    }
}
