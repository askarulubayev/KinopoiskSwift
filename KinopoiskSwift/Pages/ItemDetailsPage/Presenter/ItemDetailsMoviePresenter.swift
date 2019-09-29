//
//  ItemDetailsMoviePresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class ItemDetailsMoviePresenter: ItemDetailsPresenterProtocol {
    
    typealias DetailModel = MovieDetail
    typealias ImagesModel = SMImages
    typealias CreditModel = Cast
    
    weak var detailsView: ItemDetailsViewInput!
    
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
        detailsNetworkContext = MovieDetailNetworkContext(id: model.id!)
        imagesNetworkContext = MovieImagesNetworkContext(id: model.id!)
        creditsNetworkContext = MoiveCreditsNetworkContext(id: model.id!)
    }
    
    func loadLastCredits(completion: @escaping (Result<Void>) -> Void) {
        let networkContext = SimilarMoviesNetworkContext(id: model.id!)
        networkService.loadDecodable(context: networkContext, type: TmdbResult<Movie>.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movieResult):
                guard let movies = movieResult.results else {
                    completion(.error(NetworkError.unknown))
                    return
                }
                strongSelf.componentsBuilder.set(titleLastCredits: "Похожие фильмы", lastCreditComponents: movies)
                completion(.success(()))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}
