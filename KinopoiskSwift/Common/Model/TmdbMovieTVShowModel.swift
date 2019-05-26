//
//  TmdbMovieTVShowModel.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

protocol TmdbMovieTVShowModel: TmdbModel {
    var id: Int? { get }
    var poster_path: String? { get }
    var backdrop_path: String? { get }
    var vote_average: Double? { get }
    var overview: String? { get }
    var popularity: Double? { get }
    var original_language: String? { get }
    var genre_ids: [Int]? { get }
    var vote_count: Int? { get }
    var media_type: MediaType? { get }
    
    func getTitle() -> String?
    func originalTitle() -> String?
    func releaseDate() -> String?
}

extension TmdbMovieTVShowModel {
    func getPosterPathUrlString() -> String? {
        if let posterPath = poster_path {
            return TmdbAPI.posterPath + posterPath
        }
        return nil
    }
    
    func getBackdropPathUrlString() -> String? {
        if let backdropPath = backdrop_path {
            return TmdbAPI.posterPath + backdropPath
        }
        return nil
    }
    
    func getOriginalNameWithReleaseDate() -> String {
        if releaseDate()?.count ?? 0 >= 4 {
            return "\(originalTitle() ?? "") (\(releaseDate()?[0..<4] ?? ""))"
        }
        else{
            return originalTitle() ?? ""
        }
    }
    
    func getVoteAverageWithPopularity() -> NSAttributedString{
        let voteAverageAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let voteAverageString = NSMutableAttributedString(string: "\(vote_average ?? 0.0)", attributes: voteAverageAttributes)
        
        let popularityAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let popularityString = NSMutableAttributedString(string: "  \(popularity ?? 0.0)", attributes: popularityAttributes)
        
        voteAverageString.append(popularityString)
        return voteAverageString
    }
}
