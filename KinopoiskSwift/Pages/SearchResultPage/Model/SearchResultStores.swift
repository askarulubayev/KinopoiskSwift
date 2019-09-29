//
//  SearchResultBuilder.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/21/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

struct SearchResultBuilder {
    private var movies = [Movie]()
    private var tvs = [TVShow]()
    private var persons = [Person]()
    
    private var moviesTotalResult = 0
    private var tvsTotalResult = 0
    private var personsTotalResult = 0
    
    mutating func set(movies: [Movie], totalResult: Int) {
        self.movies = movies
        self.moviesTotalResult = totalResult
    }
    
    mutating func set(tvs: [TVShow], totalResult: Int) {
        self.tvs = tvs
        self.tvsTotalResult = totalResult
    }
    
    mutating func set(persons: [Person], totalResult: Int) {
        self.persons = persons
        self.personsTotalResult = totalResult
    }
    
    func buildHeaderComponents() -> [SearchResultHeaderComponent] {
        var headerComponents = [SearchResultHeaderComponent]()
        
        if let movieHeaderComponent = getMoviesHeaderComponents() {
            headerComponents.append(movieHeaderComponent)
        }
        if let tvHeaderComponent = getTVsHeaderComponents() {
            headerComponents.append(tvHeaderComponent)
        }
        if let personHeaderComponent = getPersonsHeaderComponents() {
            headerComponents.append(personHeaderComponent)
        }
        
        return headerComponents
    }
}

extension SearchResultBuilder {
    private func getMoviesHeaderComponents() -> SearchResultHeaderComponent? {
        guard !movies.isEmpty else { return nil }
        var moviesComponents = [SearchResultComponentType]()
        movies.prefix(3).forEach { movie in
            moviesComponents.append(.component(model: movie))
        }
        if moviesTotalResult > 3 {
            moviesComponents.append(.spacer)
            moviesComponents.append(.allResult(type: .movie, totalResult: moviesTotalResult))
        }
        
        return SearchResultHeaderComponent(
            sectionTitle: TmdbModelType.movie.title,
            components: moviesComponents
        )
    }
    
    private func getTVsHeaderComponents() -> SearchResultHeaderComponent? {
        guard !tvs.isEmpty else { return nil }
        var tvsComponetns = [SearchResultComponentType]()
        tvs.prefix(3).forEach { tv in
            tvsComponetns.append(.component(model: tv))
        }
        if tvsTotalResult > 3 {
            tvsComponetns.append(.spacer)
            tvsComponetns.append(.allResult(type: .tv, totalResult: tvsTotalResult))
        }
        
        return SearchResultHeaderComponent(
            sectionTitle: TmdbModelType.tv.title,
            components: tvsComponetns
        )
    }
    
    private func getPersonsHeaderComponents() -> SearchResultHeaderComponent? {
        guard !persons.isEmpty else { return nil }
        var personsComponents = [SearchResultComponentType]()
        persons.prefix(3).forEach { person in
            personsComponents.append(.component(model: person))
        }
        if personsTotalResult > 3 {
            personsComponents.append(.spacer)
            personsComponents.append(.allResult(type: .person, totalResult: personsTotalResult))
        }
        
        return SearchResultHeaderComponent(
            sectionTitle: TmdbModelType.person.title,
            components: personsComponents
        )
    }
}
