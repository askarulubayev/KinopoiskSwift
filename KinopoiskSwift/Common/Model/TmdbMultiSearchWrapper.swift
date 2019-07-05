//
//  TmdbMultiSearchWrapper.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/30/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

struct TmdbMultiSearchWrapper: Decodable {
    let model: TmdbModel?
    
    private enum CodingKeys: String, CodingKey {
        case media_type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MediaType.self, forKey: .media_type)
        self.model = try type.metatype.init(from: decoder)
    }
}
