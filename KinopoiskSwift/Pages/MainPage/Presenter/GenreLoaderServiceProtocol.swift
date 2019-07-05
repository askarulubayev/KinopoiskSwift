//
//  GenreLoaderServiceProtocol.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/23/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

protocol GenreLoaderServiceProtocol {
    var networkService: NetworkService { get }
}

extension GenreLoaderServiceProtocol {
    func loadGenres(onCompletion perform: @escaping (Result<Void>) -> Void) {
        var results = [Result<Void>]()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        let movieGenresNetworkContext = MovieGenresNetworkContext()
        networkService.loadDecodable(context: movieGenresNetworkContext, type: Genres.self) { result in
            switch result {
            case .success(let genres):
                MovieGenresStore.shared.set(genres: genres.genres)
                results.append(.success(()))
            case .error(let error):
                results.append(.error(error))
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        let tvGenresNetworkContext = TVGenresNetworkContext()
        networkService.loadDecodable(context: tvGenresNetworkContext, type: Genres.self) { result in
            switch result {
            case .success(let genres):
                TVGenreStore.shared.set(genres: genres.genres)
                results.append(.success(()))
            case .error(let error):
                results.append(.error(error))
            }
            dispatchGroup.leave()
        }
        
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
            perform(.success(()))
        }
    }
}
