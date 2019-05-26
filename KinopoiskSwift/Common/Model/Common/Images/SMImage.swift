//
//  SMImage.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct SMImage: Codable {
    // aspect_ratio: Number
    let file_path: String?
    let height: Int?
    let width: Int?
    let iso_639_1: String?
    let vote_average: Int?
    let vote_count: Int?
}
