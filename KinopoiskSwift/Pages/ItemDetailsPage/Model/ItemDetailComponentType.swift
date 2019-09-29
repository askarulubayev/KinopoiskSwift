//
//  ItemDetailComponentType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum ItemDetailComponentType {
    case overview(text: String)
    case images(imageUrlStrings: [String])
    case model(model: TmdbModel)
    case showAll(models: [TmdbModel])
    case spacer
}
