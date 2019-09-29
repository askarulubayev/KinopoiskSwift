//
//  TmdbPersonWrapper.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct TmdbPersonWrapper: Decodable {
    
    /// For person model
    let movieTVShowModel: TmdbMovieTVShowModel?
    
    private enum CodingKeys: String, CodingKey {
        case media_type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MediaType.self, forKey: .media_type)
        if let model = try? type.metatype.init(from: decoder) as? TmdbMovieTVShowModel {
            movieTVShowModel = model
        } else {
            movieTVShowModel = nil
        }
    }
}

struct TmdbModelWrapper: Decodable {
    
    /// for all mediaTypes
    let tmdbModel: TmdbModel?
    
    private enum CodingKeys: String, CodingKey {
        case media_type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MediaType.self, forKey: .media_type)
        tmdbModel = try type.metatype.init(from: decoder)
    }
}

