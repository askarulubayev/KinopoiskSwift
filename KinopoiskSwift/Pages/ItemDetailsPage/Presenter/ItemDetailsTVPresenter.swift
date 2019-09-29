//
//  ItemDetailsTVPresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class ItemDetailsTVPresenter: ItemDetailsPresenterProtocol {
    
    typealias DetailModel = TVShowDetail
    typealias ImagesModel = SMImages
    typealias CreditModel = Cast
    
    private weak var detailsView: ItemDetailsViewInput!
    
    var view: ItemDetailsViewInput {
        return detailsView
    }
    let model: TmdbModel
    let networkService: NetworkService
    let componentsBuilder = ItemDetailsComponentsBuilder()
    let detailsNetworkContext: NetworkContext
    let imagesNetworkContext: NetworkContext
    let titleForCredits: String = "Актеры"
    let creditsNetworkContext: NetworkContext
    
    required init(view: ItemDetailsViewInput, model: TmdbModel, networkService: NetworkService) {
        self.detailsView = view
        self.model = model
        self.networkService = networkService
        detailsNetworkContext = TVShowDetailNetworkContext(id: model.id!)
        imagesNetworkContext = TVShowImagesNetworkContext(id: model.id!)
        creditsNetworkContext = TVShowCreditsNetworkContext(id: model.id!)
    }
    
    func loadLastCredits(completion: @escaping (Result<Void>) -> Void) {
        let networkContext = SimilatTVShowsNetworkContext(id: model.id!)
        networkService.loadDecodable(context: networkContext, type: TmdbResult<TVShow>.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let tvResults):
                guard let tvs = tvResults.results else {
                    completion(.error(NetworkError.unknown))
                    return
                }
                strongSelf.componentsBuilder.set(titleLastCredits: "Похожие ТВ-шоу", lastCreditComponents: tvs)
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
