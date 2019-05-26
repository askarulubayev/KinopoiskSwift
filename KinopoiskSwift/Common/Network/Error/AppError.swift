//
//  AppError.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol AppError: Error {
    var description: String { get }
}
