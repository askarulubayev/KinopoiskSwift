//
//  TmdbDetailsModel.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol TmdbDetailsModel: Decodable {
    var id: Int? { get }
    
    func getPosterPathUrlString() -> String?
    func getTitle() -> String?
    func getSubtitle() -> String?
    func getDescription() -> String?
    func getDate() -> String?
    func getOverview() -> String?
    func getGenres() -> String?
    
    func getModelType() -> TmdbModelType
}
