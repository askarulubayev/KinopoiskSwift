//
//  SearchResultViewInput.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/2/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//


protocol SearchResultViewInput: BaseViewInputProtocol {
    func set(headerComponents: [SearchResultHeaderComponent])
}
