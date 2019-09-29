//
//  MovieDetail.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct MovieDetail: Decodable {
    let id: Int?
    let title: String?
    let original_title: String?
    let vote_average: Double?
    let vote_count: Int?
    let overview: String?
    let popularity: Double?
    let backdrop_path: String?
    let poster_path: String?
    
    let budget: Int?
    let genres: Array<Genre>?
    let production_companies: Array<ProductionCompany>?
    let production_countries: Array<ProductionCountry>?
    let spoken_languages: Array<SpokenLanguages>?
    let release_date: String?
    let revenue: Int?
    let runtime: Int?
    let status: String?
    let tagline: String?
}

extension MovieDetail: TmdbDetailsModel {
    func getGenres() -> String? {
        guard let genres = genres?.compactMap({ $0.name }).prefix(5), !genres.isEmpty else { return nil }
        return genres.joined(separator: ", ")
    }
    
    func getPosterPathUrlString() -> String? {
        guard let posterPath = poster_path else { return nil }
        return TmdbAPI.posterPath + posterPath
    }
    
    func getTitle() -> String? {
        return title
    }
    
    func getSubtitle() -> String? {
        return original_title
    }
    
    func getDescription() -> String? {
        var string = ""
        if let productionCompanies = production_companies?.compactMap({ $0.name }), !productionCompanies.isEmpty {
            string += productionCompanies.joined(separator: ", ")
        }
        return string.isEmpty ? nil : string
    }
    
    func getDate() -> String? {
        return release_date
    }
    
    func getOverview() -> String? {
        return overview
    }
    
    func getModelType() -> TmdbModelType {
        return .movie
    }
}
