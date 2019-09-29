//
//  ItemDetailsViewInput.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol ItemDetailsViewInput: BaseViewInputProtocol {
    func set(headerModel: TmdbDetailsModel)
    func set(headerComponents: [ItemDetailHeaderComponent])
}
