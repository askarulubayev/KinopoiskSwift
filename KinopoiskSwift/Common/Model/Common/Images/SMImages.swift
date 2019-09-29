//
//  SMImages.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct SMImages: Codable {
    let id: Int?
    let backdrops: [SMImage]?
    let posters: [SMImage]?
}

extension SMImages: TmdbDetailImagesModel {
    func getImageUrlStrings() -> [String]? {
        guard let posters = posters else { return nil }
        let posterStrings: [String] = posters.compactMap { image in
            guard let imageUrl = image.file_path else { return nil }
            return TmdbAPI.posterPath + imageUrl
        }
        guard !posterStrings.isEmpty else { return nil }
        return posterStrings
    }
}
