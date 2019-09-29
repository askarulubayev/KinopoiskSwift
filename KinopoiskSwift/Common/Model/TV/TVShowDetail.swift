//
//  TVShowDetail.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

struct TVShowDetail: Decodable {
    let backdrop_path: String?
    let episode_run_time: [Int]?
    let first_air_date: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let in_production: Bool?
    let languages: [String]?
    let last_air_date: String?
    let created_by: [TVCreatedBy]?
    let last_episode_to_air: TVLastEpisodeToAir?
    let name: String?
    let networks: [ProductionCompany]?
    let number_of_episodes: Int?
    let number_of_seasons: Int?
    let origin_country: [String]?
    let original_language: String?
    let original_name: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let production_companies: [ProductionCompany]?
    let status: String?
    let type: String?
    let vote_average: Double?
    let vote_count: Int?
}

extension TVShowDetail: TmdbDetailsModel {
    func getGenres() -> String? {
        guard let genres = genres?.compactMap({ $0.name }).prefix(5), !genres.isEmpty else { return nil }
        return genres.joined(separator: ", ")
    }
    
    func getPosterPathUrlString() -> String? {
        guard let posterPath = poster_path else { return nil }
        return TmdbAPI.posterPath + posterPath
    }
    
    func getTitle() -> String? {
        return name
    }
    
    func getSubtitle() -> String? {
        return original_name
    }
    
    func getDescription() -> String? {
        var string = ""
        if let productionCompanies = production_companies?.compactMap({ $0.name }), !productionCompanies.isEmpty {
            string += productionCompanies.joined(separator: ", ")
        }
        return string.isEmpty ? nil : string
    }
    
    func getDate() -> String? {
        guard let date = first_air_date?.date(withFormat: .yyyyMMdd(separator: "-")) else {
            return nil
        }
        
        return Date.dayMonthYearDateFormatter.string(from: date)
    }
    
    func getOverview() -> String? {
        guard let overview = overview else { return nil }
        return overview.isEmpty ? nil : overview
    }
    
    func getModelType() -> TmdbModelType {
        return .tv
    }
}
