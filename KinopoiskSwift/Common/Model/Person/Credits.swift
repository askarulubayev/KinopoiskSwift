//
//  Credits.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct Credits<Cast: TmdbModel>: Decodable {
    let id: Int?
    let cast: [Cast]?
}
