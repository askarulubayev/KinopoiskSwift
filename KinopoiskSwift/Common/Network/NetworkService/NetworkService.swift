//
//  NetworkService.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

protocol NetworkService {
    func load(context: NetworkContext, completion: @escaping (NetworkResponse) -> Void)
    func loadDecodable<T: Decodable>(context: NetworkContext, type: T.Type, completion: @escaping (Result<T>) -> Void)
}
