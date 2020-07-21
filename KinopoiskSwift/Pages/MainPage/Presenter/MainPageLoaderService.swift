//
//  MainPageLoaderService.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class MainPageLoaderService: GenreLoaderServiceProtocol {
    
    let networkService: NetworkService
    
    private let mainPageComponentsBuilder: MainPageComponentsBuilder
    
    init(networkService: NetworkService, mainPageComponentsBuilder: MainPageComponentsBuilder) {
        self.networkService = networkService
        self.mainPageComponentsBuilder = mainPageComponentsBuilder
    }
    
    func loadMainPage(onCompletion perform: @escaping (Result<Void>) -> Void) {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            self.loadGenres { result in
                switch result {
                case .success:
                    semaphore.signal()
                case .error(let error):
                    perform(.error(error))
                }
            }
        }
        
        DispatchQueue.global().async {
            semaphore.wait()
            let dispatchGroup = DispatchGroup()
            self.loadMainPageToComponentsStore(dispatchGroup: dispatchGroup, completion: { results in
                dispatchGroup.notify(queue: .main, execute: {
                    for result in results {
                        switch result {
                        case .success:
                            continue
                        case .error:
                            perform(result)
                            return
                        }
                    }
                    perform(.success(()))
                })
            })
        }
    }
    
    private func loadMainPageToComponentsStore(dispatchGroup: DispatchGroup, completion: ([Result<Void>]) -> Void) {
        var results = [Result<Void>]()
        
        dispatchGroup.enter()
        loadTmdbPage(route: .getMoviesUpcoming, page: 1, type: Movie.self) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.mainPageComponentsBuilder.upcomingMovies = result.1
            results.append(result.0)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadTmdbPage(route: .getMoviesNowPlaying, page: 1, type: Movie.self) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.mainPageComponentsBuilder.nowPlayingMovies = result.1
            results.append(result.0)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadTmdbPage(route: .getTVsAiringToday, page: 1, type: TVShow.self) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.mainPageComponentsBuilder.airingTodayTVShows = result.1
            results.append(result.0)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadTmdbPage(route: .getPersonsPopular, page: 1, type: Person.self) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.mainPageComponentsBuilder.popularPersons = result.1
            results.append(result.0)
            dispatchGroup.leave()
        }
        
        completion(results)
    }
    
    private func loadTmdbPage<T: TmdbModel>(
        route: TmdbRoute,
        page: Int,
        type: T.Type,
        completion: @escaping ((Result<Void>, [T])) -> Void
    ) {
        let networkContext = TestMovieNetworkContext(route: route, page: page)
        networkService.loadDecodable(context: networkContext, type: TmdbResult<T>.self) { result in
            switch result {
            case .success(let tmdbResult):
                guard let results = tmdbResult.results else {
                    completion((.error(NetworkError.dataLoad), []))
                    return
                }
                completion((.success(()), results))
            case .error(let error):
                completion((.error(error), []))
            }
        }
    }
}
