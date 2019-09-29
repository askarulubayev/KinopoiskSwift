//
//  PersonDetail.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct PersonDetail: Codable {
    let id: Int?
    let name: String?
    let also_known_as: [String]?
    let gender: Int?
    let biography: String?
    let birthday: String?
    let popularity: Double?
    let profile_path: String?
    let place_of_birth: String?
    let adult: Bool?
    let known_for_department: String?
    let deathday: String?
}

extension PersonDetail: TmdbDetailsModel {
    func getGenres() -> String? {
        return nil
    }
    
    func getPosterPathUrlString() -> String? {
        guard let profile_path = profile_path else { return nil }
        return TmdbAPI.posterPath + profile_path
    }
    
    func getTitle() -> String? {
        return name
    }
    
    func getSubtitle() -> String? {
        return known_for_department
    }
    
    func getDescription() -> String? {
        return place_of_birth
    }
    
    func getDate() -> String? {
        return birthday
    }
    
    func getOverview() -> String? {
        return biography
    }
    
    func getModelType() -> TmdbModelType {
        return .person
    }
}
