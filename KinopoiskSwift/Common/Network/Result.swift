//
//  Result.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

enum Result<Value> {
    case success(Value)
    case error(AppError)
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .error:
            return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .error:
            return nil
        }
    }
    
    public var error: AppError? {
        switch self {
        case .success:
            return nil
        case .error(let error):
            return error
        }
    }
}
