//
//  Cast.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct Cast: Codable {
    let id: Int?
    let cast_id: Int?
    let character: String?
    let credit_id: String?
    let gender: Int?
    let name: String?
    let order: Int?
    let profile_path: String?
}

extension Cast: TmdbModel {
    func getTitle() -> String? {
        return name
    }
    
    func getSubtitle() -> String? {
        return nil
    }
    
    func getPosterPathUrlString() -> String? {
        return TmdbAPI.posterPath + (profile_path ?? "")
    }
    
    func getModelType() -> TmdbModelType {
        return .person
    }
}
