//
//  Person.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct Person {
    let profile_path: String?
    let adult: Bool?
    let id: Int?
    let name: String?
    let popularity: Double?
    let known_for: [TmdbPersonWrapper]?
}

extension Person: TmdbModel {
    func getTitle() -> String? {
        return name
    }
    
    func getSubtitle() -> String? {
        return nil
    }
    
    func getPosterPathUrlString() -> String? {
        if let profilePath = profile_path {
            return TmdbAPI.posterPath + profilePath
        }
        return nil
    }
    
    func getModelType() -> TmdbModelType {
        return .person
    }
}
