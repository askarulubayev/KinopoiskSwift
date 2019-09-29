//
//  TmdbPageableListType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum TmdbPageableListType: Equatable {
    // movie
    case upcomingMovies
    case topRatedMovies
    case popularMovies
    case nowPlayingMovies
    case similarMovies
    
    // tv
    case airingTodayTVShows
    case onTheAirTVShows
    case popularTVShows
    case topRatedTVShows
    case similarTVShows
    
    // person
    case popularPersons
    
    var title: String {
        switch self {
        // movie
        case .upcomingMovies:
            return "Скоро в кино"
        case .topRatedMovies:
            return "Список лучших фильмов"
        case .popularMovies:
            return "Популярные фильмы"
        case .nowPlayingMovies:
            return "Сегодня в кино"
        case .similarMovies:
            return "Поохожие фильмы"
            
        // tv
        case .airingTodayTVShows:
            return "Сегодняшние ТВ-шоу"
        case .onTheAirTVShows:
            return "Уже в эфирах"
        case .popularTVShows:
            return "Популярные ТВ-шоу"
        case .topRatedTVShows:
            return "Список лучших ТВ-шоу"
        case .similarTVShows:
            return "Похожие ТВ-шоу"
            
        // person
        case .popularPersons:
            return "Популярные актеры"
        }
    }
    
    func getNetworkContext(id: Int = -1, page: Int) -> NetworkContext {
        switch self {
        // movie
        case .upcomingMovies:
            return UpcomingMoviesNetworkContext(page: page)
        case .topRatedMovies:
            return TopRatedMoviesNetworkContext(page: page)
        case .popularMovies:
            return PopularMoviesNetworkContext(page: page)
        case .nowPlayingMovies:
            return NowPlayingMoviesNetworkContext(page: page)
        case .similarMovies:
            return SimilarMoviesNetworkContext(id: id, page: page)
            
        // tv
        case .airingTodayTVShows:
            return AiringTodayTVsNetworkContext(page: page)
        case .onTheAirTVShows:
            return OnTheAirTVsNetworkContext(page: page)
        case .popularTVShows:
            return PopularTVsNetworkContext(page: page)
        case .topRatedTVShows:
            return TopRatedTVsNetworkContext(page: page)
        case .similarTVShows:
            return SimilatTVShowsNetworkContext(id: id, page: page)
            
        // person
        case .popularPersons:
            return PopularPersonsNetworkContext(page: page)
        }
    }
    
    var modelType: TmdbModelType {
        switch self {
        case .upcomingMovies, .topRatedMovies, .popularMovies, .nowPlayingMovies, .similarMovies:
            return .movie
        case .airingTodayTVShows, .onTheAirTVShows, .popularTVShows, .topRatedTVShows, .similarTVShows:
            return .tv
        case .popularPersons:
            return .person
        }
    }
}
