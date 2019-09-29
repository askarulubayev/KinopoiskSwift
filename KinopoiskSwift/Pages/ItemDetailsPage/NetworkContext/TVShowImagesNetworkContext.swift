//
//  TVShowImagesNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/10/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class TVShowImagesNetworkContext: NetworkContext {
    
    let route: TmdbRoute
    let method: NetworkMethod = .get
    var parameters = [String : Any]()
    
    init(id: Int) {
        route = .getTVImages(id: id)
    }
}
