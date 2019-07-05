//
//  SearchLoaderService.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class SearchLoaderService {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func search<T: Decodable>(networkContext: NetworkContext, type: T.Type, completion: @escaping (Result<TmdbResult<T>>) -> Void) {
        networkService.loadDecodable(context: networkContext, type: TmdbResult<T>.self) { result in
            switch result {
            case .success(let tmdbResult):
                completion(.success(tmdbResult))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
