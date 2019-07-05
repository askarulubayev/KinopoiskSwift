//
//  SearchPromptsResultViewDelegate.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

protocol SearchPromptsResultViewDelegate: class {
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    )
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat
}

extension SearchPromptsResultViewDelegate {
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {}
    func searchPromptsResultView(
        _ searchPromptsResultView: SearchPromptsResultViewController,
        tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat { return 64 }
}
