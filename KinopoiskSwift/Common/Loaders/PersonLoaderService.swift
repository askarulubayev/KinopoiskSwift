//
//  PersonLoaderService.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class PersonLoaderService {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadPopularPersons(page: Int, completion: @escaping (Result<[Person]>) -> Void) {
        let networkContext = PopularPersonsNetworkContext(page: page)
        networkService.loadDecodable(context: networkContext, type: TmdbResult<Person>.self) { result in
            switch result {
            case .success(let tmdbResult):
                guard let persons = tmdbResult.results else {
                    completion(.error(NetworkError.dataLoad))
                    return
                }
                completion(.success(persons))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
