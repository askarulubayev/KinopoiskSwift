//
//  ListItemsViewInput.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/26/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol ListItemsViewInput: BaseViewInputProtocol {
    func set(models: [TmdbModel])
    func set(maxResult: Int)
}
