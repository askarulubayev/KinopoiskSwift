//
//  MainPageCellType.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/25/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

enum MainPageCellType {
    case showAllItems(listType: TmdbPageableListType)
    case horizontalListItems(models: [TmdbModel])
    case showAllItemsWithBigTitle(listType: TmdbPageableListType)
    case showAllItemsSkeleton
    case horizontalListItemsSkeleton
}
