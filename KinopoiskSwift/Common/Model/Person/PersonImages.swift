//
//  PersonImages.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/10/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct PersonImages: Codable {
    let id: Int?
    let profiles: [SMImage]?
}

extension PersonImages: TmdbDetailImagesModel {
    func getImageUrlStrings() -> [String]? {
        guard let profiles = profiles else { return nil }
        let profilesStrings: [String] = profiles.compactMap { image in
            guard let imageUrl = image.file_path else { return nil }
            return TmdbAPI.posterPath + imageUrl
        }
        guard !profilesStrings.isEmpty else { return nil }
        return profilesStrings
    }
}
