//
//  TmdbResult.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct TmdbResult<T: Decodable>: Decodable {
    let results: [T]?
    let total_results: Int?
    let total_pages: Int?
    let page: Int?
}
