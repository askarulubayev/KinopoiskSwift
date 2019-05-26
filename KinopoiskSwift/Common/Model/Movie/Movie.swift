//
//  Movie.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct Movie {
    let id: Int?
    let title: String?
    let original_title: String?
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double?
    let overview: String?
    let release_date: String?
    let popularity: Double?
    let original_language: String?
    let genre_ids: [Int]?
    let vote_count: Int?
    let video: Bool?
    let adult: Bool?
    let media_type: MediaType?
}

// MARK: - extension which implements TmdbModel
extension Movie {
    func getSubtitle() -> String? {
        return getOriginalNameWithReleaseDate()
    }
    
    func getModelType() -> TmdbModelType {
        return .movie
    }
}

extension Movie: TmdbMovieTVShowModel {
    func getTitle() -> String? {
        return title
    }
    
    func originalTitle() -> String? {
        return original_title
    }
    
    func releaseDate() -> String? {
        return release_date
    }
}
