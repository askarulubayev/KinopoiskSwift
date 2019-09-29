//
//  ItemDetailsPresenterProtocol.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

protocol ItemDetailsPresenterProtocol: ItemDetailsPresenterInput {
    
    associatedtype DetailModel: TmdbDetailsModel
    associatedtype ImagesModel: TmdbDetailImagesModel
    associatedtype CreditModel: TmdbModel
    
    var view: ItemDetailsViewInput { get }
    var model: TmdbModel { get }
    var networkService: NetworkService { get }
    var componentsBuilder: ItemDetailsComponentsBuilder { get }
    var detailsNetworkContext: NetworkContext { get }
    var imagesNetworkContext: NetworkContext { get }
    var titleForCredits: String { get }
    var creditsNetworkContext: NetworkContext { get }
    
    init(view: ItemDetailsViewInput, model: TmdbModel, networkService: NetworkService)
    
    func loadLastCredits(completion: @escaping (Result<Void>) -> Void)
}

extension ItemDetailsPresenterProtocol {
    func loadDetails() {
        
        view.showActivityIndicator()
        let dispatchGroup = DispatchGroup()
        
        var results = [Result<Void>]()
        
        dispatchGroup.enter()
        loadDetails { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadImages { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadCredits { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadLastCredits { result in
            results.append(result)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.view.hideActivityIndicator()
            for result in results {
                switch result {
                case .success:
                    continue
                case .error(let error):
                    self.view.showError(message: error.description)
                }
            }
            self.view.set(headerComponents: self.componentsBuilder.headerComponents)
        }
    }
    
    private func loadDetails(completion: @escaping (Result<Void>) -> Void) {
        networkService.loadDecodable(context: detailsNetworkContext, type: DetailModel.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let details):
                strongSelf.componentsBuilder.set(detailModel: details)
                strongSelf.view.set(headerModel: details)
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    private func loadImages(completion: @escaping (Result<Void>) -> Void) {
        networkService.loadDecodable(context: imagesNetworkContext, type: ImagesModel.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let images):
                strongSelf.componentsBuilder.set(images: images)
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    private func loadCredits(completion: @escaping (Result<Void>) -> Void) {
        networkService.loadDecodable(context: creditsNetworkContext, type: Credits<CreditModel>.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let result):
                guard let cast = result.cast else {
                    completion(.error(NetworkError.unknown))
                    return
                }
                strongSelf.componentsBuilder.set(titleCredits: strongSelf.titleForCredits, componentsCredits: cast)
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
