//
//  AiringTodayTVSNetworkContext.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class AiringTodayTVsNetworkContext: NetworkContext {
    var route: TmdbRoute { return .getTVsAiringToday }
    var method: NetworkMethod { return .get }
    var parameters = [String: Any]()
    
    init(page: Int) {
        parameters["page"] = page
    }
}