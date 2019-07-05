//
//  MainPagePresenterInput.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/22/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol MainPagePresenterInput {
    func loadMainPage()
    func refreshMainPage()
    func searchMulti(text: String)
}
