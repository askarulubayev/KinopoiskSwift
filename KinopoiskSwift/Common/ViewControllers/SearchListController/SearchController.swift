//
//  SearchController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 7/5/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SearchController: UISearchController {
    
    lazy private var customSearchBar = SearchBar()
}

extension SearchController: UISearchBarDelegate {
    
    override var searchBar: UISearchBar { return customSearchBar }
}

class SearchBar: UISearchBar {
    
}
