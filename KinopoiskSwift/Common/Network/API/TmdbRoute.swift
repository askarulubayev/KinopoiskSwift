//
//  TmdbRoute.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

enum TmdbRoute {
    
    case getMoviesNowPlaying
    case getMoviesTopRated
    case getMoviesPopular
    case getMoviesUpcoming
    case getMovieDetail(id: Int)
    case getMovieCredits(id: Int)
    case getMovieImages(id: Int)
    case getMovieKeywords(id: Int)
    case getMoviesSimilar(id: Int)
    case getMovieVideos(id: Int)
    case getMovieReviews(id: Int)
    
    case getTVsAiringToday
    case getTVsOnTheAir
    case getTVsPopular
    case getTVsTopRated
    case getTVDetail(id: Int)
    case getTVCredits(id: Int)
    case getTVImages(id: Int)
    case getTVKeywords(id: Int)
    case getTVsSimilar(id: Int)
    case getTVVideos(id: Int)
    
    case getPersonsPopular
    case getPersonDetails(id: Int)
    case getPersonMovieCredits(id: Int)
    case getPersonTVCredits(id: Int)
    case getPersonImages(id: Int)
    
    case getMovieGenres
    case getTVGenres
    
    case searchPerson
    case searchMovie
    case searchTV
    case searchMulti
    
    private func getRoute() -> String {
        switch self {
        case .getMoviesNowPlaying:
            return "movie/now_playing"
        case.getMoviesTopRated:
            return "movie/top_rated"
        case .getMoviesPopular:
            return "movie/popular"
        case .getMoviesUpcoming:
            return "movie/upcoming"
        case .getMovieDetail(let id):
            return "movie/" + id.description
        case .getMovieCredits(let id):
            return "movie/" + id.description + "/credits"
        case .getMovieImages(let id):
            return "movie/" + id.description + "/images"
        case .getMovieKeywords(let id):
            return "movie/" + id.description + "/keywords"
        case .getMoviesSimilar(let id):
            return "movie/" + id.description + "/similar"
        case .getMovieVideos(let id):
            return "movie/" + id.description + "/videos"
        case .getMovieReviews(let id):
            return "movie/" + id.description + "/reviews"
            
        case .getTVsAiringToday:
            return "tv/airing_today"
        case .getTVsOnTheAir:
            return "tv/on_the_air"
        case .getTVsPopular:
            return "tv/popular"
        case .getTVsTopRated:
            return "tv/top_rated"
        case .getTVDetail(let id):
            return "tv/" + id.description
        case .getTVCredits(let id):
            return "tv/" + id.description + "/credits"
        case .getTVImages(let id):
            return "tv/" + id.description + "/images"
        case .getTVKeywords(let id):
            return "tv/" + id.description + "/keywords"
        case .getTVsSimilar(let id):
            return "tv/" + id.description + "/similar"
        case .getTVVideos(let id):
            return "tv/" + id.description + "/videos"
            
        case .getPersonsPopular:
            return "person/popular"
        case .getPersonDetails(let id):
            return "person/" + id.description
        case .getPersonMovieCredits(let id):
            return "person/" + id.description + "/movie_credits"
        case .getPersonTVCredits(let id):
            return "person/" + id.description + "/tv_credits"
        case .getPersonImages(let id):
            return "person/" + id.description + "/images"
            
        case .getMovieGenres:
            return "genre/movie/list"
        case .getTVGenres:
            return "genre/tv/list"
            
            
        case .searchPerson:
            return "search/person"
        case .searchTV:
            return "search/tv"
        case .searchMovie:
            return "search/movie"
        case .searchMulti:
            return "search/multi"
        }
    }
}

extension TmdbRoute: URLConvertible {
    func url() -> URL? {
        return URL(string: TmdbAPI.baseURLString + getRoute())
    }
}
