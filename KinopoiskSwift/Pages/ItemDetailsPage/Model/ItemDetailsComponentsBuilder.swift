//
//  ItemDetailsComponentsBuilder.swift
//  KinopoiskSwift
//
//  Created by Аскар on 8/4/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

class ItemDetailsComponentsBuilder {
    
    var headerComponents: [ItemDetailHeaderComponent] {
        var headerComponents = [ItemDetailHeaderComponent]()
        
        var components = [ItemDetailComponentType]()
        
        if let overview = detailModel?.getOverview(), !overview.isEmpty {
            components.append(.overview(text: overview))
        }
        
        if let images = images?.getImageUrlStrings(), !images.isEmpty {
            components.append(.images(imageUrlStrings: images))
        }
        
        if !components.isEmpty {
            headerComponents.append(ItemDetailHeaderComponent(headerComponent: .emptyHeader, components: components))
        }
        
        if let creditComponents = creditComponents, !creditComponents.isEmpty, let title = titleCredits {
            var components = [ItemDetailComponentType]()
            let creditComponentsPrefix = creditComponents.prefix(3)
            creditComponentsPrefix.forEach { model in
                components.append(.model(model: model))
            }
            if creditComponents.count > 3 {
                components.append(.spacer)
                components.append(.showAll(models: creditComponents))
            }
            headerComponents.append(ItemDetailHeaderComponent(headerComponent: .headerWith(title: title), components: components))
        }
        
        if let lastCreditComponents = lastCreditComponents, !lastCreditComponents.isEmpty, let title = titleLastCredits {
            var components = [ItemDetailComponentType]()
            let creditComponentsPrefix = lastCreditComponents.prefix(3)
            creditComponentsPrefix.forEach { model in
                components.append(.model(model: model))
            }
            if lastCreditComponents.count > 3 {
                components.append(.spacer)
                components.append(.showAll(models: lastCreditComponents))
            }
            headerComponents.append(ItemDetailHeaderComponent(headerComponent: .headerWith(title: title), components: components))
        }
        
        return headerComponents
    }
    
    private var detailModel: TmdbDetailsModel?
    private var images: TmdbDetailImagesModel?
    
    private var titleCredits: String?
    private var creditComponents: [TmdbModel]?
    
    private var titleLastCredits: String?
    private var lastCreditComponents: [TmdbModel]?
    
    func set(detailModel: TmdbDetailsModel) {
        self.detailModel = detailModel
    }
    
    func set(images: TmdbDetailImagesModel) {
        self.images = images
    }
    
    func set(titleCredits: String, componentsCredits: [TmdbModel]) {
        self.titleCredits = titleCredits
        self.creditComponents = componentsCredits
    }
    
    func set(titleLastCredits: String, lastCreditComponents: [TmdbModel]) {
        self.titleLastCredits = titleLastCredits
        self.lastCreditComponents = lastCreditComponents
    }
}
