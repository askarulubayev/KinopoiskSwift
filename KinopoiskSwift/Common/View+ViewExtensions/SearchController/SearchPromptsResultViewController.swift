//
//  SearchPromptsResultViewController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/1/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SearchPromptsResultViewController: UITableViewController {
    
    weak var dataSource: SearchPromptsResultViewDataSource?
    weak var delegate: SearchPromptsResultViewDelegate?
    
    let cellIdentier: String
    let cellClass: AnyClass
    
    init(cellIdentier: String, cellClass: AnyClass) {
        self.cellIdentier = cellIdentier
        self.cellClass = cellClass
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeViews()
    }
}

extension SearchPromptsResultViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.searchPromptsResultViewNumberOOfSections(in: tableView) ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.searchPromptsResultView(self, tableView: tableView, numberOfRowsInSection: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource?.searchPromptsResultView(self, tableView: tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}

extension SearchPromptsResultViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchPromptsResultView(self, tableView: tableView, didSelectRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.searchPromptsResultView(self, tableView: tableView, heightForRowAt: indexPath) ?? 64.0
    }
}

extension SearchPromptsResultViewController {
    private func stylizeViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        tableView.backgroundColor = .clear
        tableView.register(cellClass, forCellReuseIdentifier: cellIdentier)
    }
}
