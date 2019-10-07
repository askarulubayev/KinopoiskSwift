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
    
    private lazy var movieLoaderService = MovieLoaderService(networkService: networkService)
    private lazy var tvShowLoaderService = TVShowLoaderService(networkService: networkService)
    private lazy var personLoaderService = PersonLoaderService(networkService: networkService)
    
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
        loadUpcomingMoviesToComponentsStore { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadNowPlayingMoviesToComponentsStore { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadAiringTodayTVShowsToComponentsStore { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadPopularPeersonsToComponentsStore { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        completion(results)
    }
    
    private func loadUpcomingMoviesToComponentsStore(completion: @escaping (Result<Void>) -> Void) {
        movieLoaderService.loadUpcomingMovies(page: 1) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movies):
                strongSelf.mainPageComponentsBuilder.upcomingMovies = movies
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    private func loadNowPlayingMoviesToComponentsStore(completion: @escaping (Result<Void>) -> Void) {
        movieLoaderService.loadNowPlayingMovies(page: 1) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movies):
                strongSelf.mainPageComponentsBuilder.nowPlayingMovies = movies
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    private func loadAiringTodayTVShowsToComponentsStore(completion: @escaping (Result<Void>) -> Void) {
        tvShowLoaderService.loadAiringTodayTVShows(page: 1) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let tvShows):
                strongSelf.mainPageComponentsBuilder.airingTodayTVShows = tvShows
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    private func loadPopularPeersonsToComponentsStore(completion: @escaping (Result<Void>) -> Void) {
        personLoaderService.loadPopularPersons(page: 1) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let persons):
                strongSelf.mainPageComponentsBuilder.popularPersons = persons
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
