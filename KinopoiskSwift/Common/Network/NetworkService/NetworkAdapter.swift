//
//  NetworkAdapter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Alamofire

class NetworkAdapter: NetworkService {
    
    func load(context: NetworkContext, completion: @escaping (NetworkResponse) -> Void) {
        guard let url = context.url else {
            completion(FailureNetworkResponse(networkError: .urlValid))
            return
        }
        
        context.setDefaultParameters()
        
        Alamofire.request(
            url,
            method: httpMethod(method: context.method),
            parameters: context.parameters,
            encoding: encoding(encoding: context.encoding)
        ).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.log(response: response)
            completion(strongSelf.dataResponseToNetworkResponse(response: response))
        }
    }
    
    func loadDecodable<T: Decodable>(context: NetworkContext, type: T.Type, completion: @escaping (Result<T>) -> Void) {
        load(context: context) { networkResponse in
            if let error = networkResponse.networkError {
                completion(.error(error))
                return
            }
            guard let result: T = networkResponse.decode() else {
                completion(.error(NetworkError.dataLoad))
                return
            }
            completion(.success(result))
        }
    }
    
    private func httpMethod(method: NetworkMethod) -> HTTPMethod {
        switch method {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    private func encoding(encoding: NetworkEncoding) -> ParameterEncoding {
        switch encoding {
        case .json:
            return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
    
    private func dataResponseToNetworkResponse(response: DataResponse<Any>) -> NetworkResponse {
        if let serverError = response.error {
            return FailureNetworkResponse(networkError: .serverError(description: serverError.localizedDescription))
        }
        guard let data = response.data else {
            return FailureNetworkResponse(networkError: .dataLoad)
        }
        return SucceessNetworkResponse(data: data)
    }
    
    private func log(response: DataResponse<Any>) {
        print("--------URL------------")
        print(response.request?.url?.absoluteString ?? "nil")
        print("--------Data-----------")
        if let data = response.data {
            print(data.prettyPrintedJSONString ?? "")
        } else {
            print("Data is nil")
        }
        print("--------END------------")
    }
}
