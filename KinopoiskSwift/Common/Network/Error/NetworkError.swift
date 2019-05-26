//
//  NetworkError.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum NetworkError: AppError {
    case serverError(description: String)
    case dataLoad
    case unknown
    case noConnection
    case urlValid
    
    var description: String {
        switch self {
        case .serverError(let description):
            return description
        case .dataLoad:
            return "Возникла ошибка при загрузке данных. Приносим свои извинения за доставленные неудобства."
        case .unknown, .urlValid:
            return "Возникла непредвиденная ошибка. Приносим свои извинения за доставленные неудобства."
        case .noConnection:
            return "Отсутствует интернет соединение"
        }
    }
}
