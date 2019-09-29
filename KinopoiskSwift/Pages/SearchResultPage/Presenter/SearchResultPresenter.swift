//
//  SearchResultPresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/2/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class SearchResultPresenter {
    
    private weak var view: SearchResultViewInput!
    private let networkService: NetworkService
    private let query: String
    private var headerComponents = [SearchResultHeaderComponent]()
    private let searchLoaderService: SearchLoaderService
    private var searchResultStore = SearchResultBuilder()
    
    init(view: SearchResultViewInput, networkService: NetworkService, query: String) {
        self.view = view
        self.networkService = networkService
        self.query = query
        searchLoaderService = SearchLoaderService(networkService: networkService)
    }
    
    // TODO: Отрефакторить
    func showHeaderComponents(perform: @escaping (Result<Void>) -> Void) {
        let dispatchGroup = DispatchGroup()
        generateHeaderComponents(dispatchGroup: dispatchGroup) { [weak self] results in
            guard let strongSelf = self else { return }
            dispatchGroup.notify(queue: .main) {
                for result in results {
                    switch result {
                    case .success:
                        continue
                    case .error:
                        perform(result)
                        return
                    }
                }
                strongSelf.headerComponents = strongSelf.searchResultStore.buildHeaderComponents()
                perform(.success(()))
            }
        }
    }
    
    // TODO: Отрефакторить
    private func generateHeaderComponents(dispatchGroup: DispatchGroup, completion: ([Result<Void>]) -> Void) {
        headerComponents.removeAll()
        
        var results = [Result<Void>]()
        
        dispatchGroup.enter()
        let movieSearchNetworkContext = TmdbSearchPageableListType.searchMovie.getNetworkContext(query: query, page: 1)
        searchLoaderService.search(
            networkContext: movieSearchNetworkContext,
            type: Movie.self
        ) { [weak self] result in
            
            dispatchGroup.leave()
            guard let strongSelf = self else { return }
            switch result {
            case .success(let tmdbResult):
                if let movies = tmdbResult.results, let totalResult = tmdbResult.total_results {
                    strongSelf.searchResultStore.set(movies: movies, totalResult: totalResult)
                    results.append(.success(()))
                } else {
                    results.append(.error(NetworkError.unknown))
                }
            case .error(let error):
                results.append(.error(error))
                print(error.description)
            }
        }
        
        let tvSearchNetworkContext = TmdbSearchPageableListType.searchTV.getNetworkContext(query: query, page: 1)
        dispatchGroup.enter()
        searchLoaderService.search(
            networkContext: tvSearchNetworkContext,
            type: TVShow.self
        ) { [weak self] result in
            
            dispatchGroup.leave()
            guard let strongSelf = self else { return }
            switch result {
            case .success(let tmdbResult):
                if let tvs = tmdbResult.results, let totalResult = tmdbResult.total_results {
                    strongSelf.searchResultStore.set(tvs: tvs, totalResult: totalResult)
                    results.append(.success(()))
                } else {
                    results.append(.error(NetworkError.unknown))
                }
            case .error(let error):
                results.append(.error(error))
                print(error.description)
            }
        }
        
        let personSearchNetworkContext = TmdbSearchPageableListType.searchPerson.getNetworkContext(query: query, page: 1)
        dispatchGroup.enter()
        searchLoaderService.search(
            networkContext: personSearchNetworkContext,
            type: Person.self
        ) { [weak self] result in
            
            dispatchGroup.leave()
            guard let strongSelf = self else { return }
            switch result {
            case .success(let tmdbResult):
                if let persons = tmdbResult.results, let totalResult = tmdbResult.total_results {
                    strongSelf.searchResultStore.set(persons: persons, totalResult: totalResult)
                    results.append(.success(()))
                } else {
                    results.append(.error(NetworkError.unknown))
                }
            case .error(let error):
                results.append(.error(error))
                print(error.description)
            }
        }
        
        completion(results)
    }
}

extension SearchResultPresenter: SearchResultPresenterInput {
    func loadComponents() {
        showHeaderComponents { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.view.set(headerComponents: strongSelf.headerComponents)
            case .error(let error):
                strongSelf.view.showError(message: error.description)
            }
        }
    }
}
