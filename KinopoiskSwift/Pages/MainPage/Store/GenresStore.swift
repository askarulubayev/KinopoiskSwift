//
//  GenresStore.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/23/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class GenresStore {
    private var genresDictionaty = [Int: String]()
    
    func set(genres: [Genre]) {
        genres.forEach { genre in
            if let id = genre.id, let name = genre.name {
                genresDictionaty[id] = name
            }
        }
    }
    
    func getGenres(ids: [Int]) -> [String]? {
        var genres = [String]()
        ids.forEach { id in
            if let genre = genresDictionaty[id] {
                genres.append(genre)
            }
        }
        guard !genres.isEmpty else { return nil }
        return genres
    }
    
    func getGenreTitleFrom(id: Int?) -> String? {
        guard let id = id else { return nil }
        return genresDictionaty[id]
    }
}
