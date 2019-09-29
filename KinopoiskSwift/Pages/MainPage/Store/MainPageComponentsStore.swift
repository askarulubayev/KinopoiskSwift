//
//  MainPageStores.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class MainPageComponentsStore {
    var upcomingMovies = [Movie]()
    var nowPlayingMovies = [Movie]()
    var airingTodayTVShows = [TVShow]()
    var popularPersons = [Person]()
    
    private var headerComponents = [MainPageHeaderComponent]()
    
    func convertToHeaderComponents() -> [MainPageHeaderComponent] {
        headerComponents.removeAll()
        headerComponents.append(getMoviesComponent())
        headerComponents.append(getTVShowsComponent())
        headerComponents.append(getPersonsComponent())
        return headerComponents
    }
    
    private func getMoviesComponent() -> MainPageHeaderComponent {
        return MainPageHeaderComponent(
            sectionTitle: TmdbModelType.movie.title,
            components: [
                .showAllItemsWithBigTitle(listType: TmdbPageableListType.nowPlayingMovies),
                .horizontalListItems(models: nowPlayingMovies),
                .showAllItems(listType: TmdbPageableListType.popularMovies),
                .showAllItems(listType: TmdbPageableListType.topRatedMovies),
                .showAllItems(listType: TmdbPageableListType.upcomingMovies)
            ]
        )
    }
    
    private func getTVShowsComponent() -> MainPageHeaderComponent {
        return MainPageHeaderComponent(
            sectionTitle: TmdbModelType.tv.title,
            components: [
                .showAllItemsWithBigTitle(listType: TmdbPageableListType.airingTodayTVShows),
                .horizontalListItems(models: airingTodayTVShows),
                .showAllItems(listType: TmdbPageableListType.popularTVShows),
                .showAllItems(listType: TmdbPageableListType.topRatedTVShows),
                .showAllItems(listType: TmdbPageableListType.onTheAirTVShows)
            ]
        )
    }
    
    private func getPersonsComponent() -> MainPageHeaderComponent {
        return MainPageHeaderComponent(
            sectionTitle: TmdbModelType.person.title,
            components: [
                .showAllItemsWithBigTitle(listType: TmdbPageableListType.popularPersons),
                .horizontalListItems(models: popularPersons)
            ]
        )
    }
}
