//
//  TmdbModel.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol TmdbModel: Decodable {
    var id: Int? { get }
    
    func getTitle() -> String?
    func getSubtitle() -> String?
    func getPosterPathUrlString() -> String?
    func getModelType() -> TmdbModelType
}
