//
//  ItemDetailsPersonPresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class ItemDetailsPersonPresenter: ItemDetailsPresenterProtocol {
    
    typealias DetailModel = PersonDetail
    typealias ImagesModel = PersonImages
    typealias CreditModel = Movie
    
    weak var detailsView: ItemDetailsViewInput!
    
    var view: ItemDetailsViewInput {
        return detailsView
    }
    let model: TmdbModel
    let networkService: NetworkService
    let componentsBuilder = ItemDetailsComponentsBuilder()
    let detailsNetworkContext: NetworkContext
    let imagesNetworkContext: NetworkContext
    let titleForCredits: String = "Фильмы"
    let creditsNetworkContext: NetworkContext
    
    required init(view: ItemDetailsViewInput, model: TmdbModel, networkService: NetworkService) {
        self.detailsView = view
        self.model = model
        self.networkService = networkService
        detailsNetworkContext = PersonDetailNetworkContext(id: model.id!)
        imagesNetworkContext = PersonImagesNetworkContext(id: model.id!)
        creditsNetworkContext = PersonMovieCreditsNetworkContext(id: model.id!)
    }
    
    func loadLastCredits(completion: @escaping (Result<Void>) -> Void) {
        let networkContext = PersonTVCreditsNetworkContext(id: model.id!)
        networkService.loadDecodable(context: networkContext, type: Credits<TVShow>.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let credits):
                guard let casts = credits.cast else {
                    completion(.error(NetworkError.unknown))
                    return
                }
                strongSelf.componentsBuilder.set(titleLastCredits: "ТВ-шоу", lastCreditComponents: casts)
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
