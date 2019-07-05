//
//  SearchPromptsResultViewDataSource.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

protocol SearchPromptsResultViewDataSource: class {
    func searchPromptsResultViewNumberOOfSections(in tableView: UITableView) -> Int
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell
}

extension SearchPromptsResultViewDataSource {
    func searchPromptsResultViewNumberOOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
