//
//  MainPagePresenter.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/22/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import Foundation

class MainPagePresenter {
    
    weak var view: MainPageViewInput!
    
    private let networkService: NetworkService = NetworkAdapter()
    
    private lazy var loaderService = MainPageLoaderService(
        networkService: networkService,
        mainPageComponentsStore: mainPageComponentsStore
    )
    private let mainPageComponentsStore = MainPageComponentsStore()
    
    init(view: MainPageViewInput) {
        self.view = view
    }
}

extension MainPagePresenter: MainPagePresenterInput {
    func loadMainPage() {
        loadAllData(isActivityIndicatorVisible: true)
    }
    
    func refreshMainPage() {
        loadAllData(isActivityIndicatorVisible: false)
    }
    
    func searchMulti(text: String) {
        let networkContext = MultiSearchNetworkContext(query: text, page: 1)
        networkService.loadDecodable(context: networkContext, type: TmdbResult<TmdbModelWrapper>.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let models):
                strongSelf.view.set(searchResult: models.results?.compactMap { $0.tmdbModel } ?? [])
            case .error(let error):
                print(error.description)
            }
        }
    }
    
    private func loadAllData(isActivityIndicatorVisible: Bool) {
        
        if isActivityIndicatorVisible { view.showActivityIndicator() }
        loaderService.loadMainPage { [weak self] result in
            guard let strongSelf = self else { return }
            if isActivityIndicatorVisible { strongSelf.view.hideActivityIndicator() }
            switch result {
            case .success: break
            case .error(let error):
                strongSelf.view.showError(message: error.description)
            }
            let upcomingMovies = strongSelf.mainPageComponentsStore.upcomingMovies
            let headerComponents = strongSelf.mainPageComponentsStore.convertToHeaderComponents()
            if !upcomingMovies.isEmpty && !headerComponents.isEmpty {
                strongSelf.view.set(upcomingMovies: upcomingMovies)
                strongSelf.view.set(headerComponents: headerComponents)
            } else {
                strongSelf.view.showError(message: NetworkError.noConnection.description)
            }
        }
    }
}
