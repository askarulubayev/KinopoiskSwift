//
//  TVShow.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct TVShow {
    let id: Int?
    let name: String?
    let original_name: String?
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double?
    let overview: String?
    let first_air_date: String?
    let popularity: Double?
    let original_language: String?
    let genre_ids: [Int]?
    let vote_count: Int?
    let origin_country: [String]?
    let media_type: MediaType?
}

// MARK: - extension which implements TmdbModel
extension TVShow {
    func getSubtitle() -> String? {
        return getOriginalNameWithReleaseDate()
    }
    
    func getModelType() -> TmdbModelType {
        return .tv
    }
}

extension TVShow: TmdbMovieTVShowModel {
    func getTitle() -> String? {
        return name
    }
    
    func originalTitle() -> String? {
        return original_name
    }
    
    func releaseDate() -> String? {
        return first_air_date
    }
}
