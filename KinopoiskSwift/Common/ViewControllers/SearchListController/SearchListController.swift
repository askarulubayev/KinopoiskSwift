//
//  SearchListController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 7/5/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class SearchListController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    var searchController: SearchController?
    var isHidden: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.5) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
        
        view.addSubview(tableView)
        
        setViewConstraints()
        stylizeViews()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setSearchController() {
        guard let searchController = searchController else {
            fatalError("Should set searchController")
        }
        searchController.definesPresentationContext = true
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(activateSearchController)
        )
    }
    
    func setViewConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylizeViews() {
        view.backgroundColor = AppColor.whitish.uiColor
        
        if tableView.tableHeaderView == nil {
            tableView.tableHeaderView = searchController?.searchBar
        }
        searchController?.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 107.5
        tableView.sectionHeaderHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
    }
    
    @objc func activateSearchController() {
        searchController?.searchBar.isUserInteractionEnabled = false
        guard let controller = searchController else { return }
        present(controller, animated: true)
    }
}

extension SearchListController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        isHidden = true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        isHidden = false
    }
}

extension SearchListController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "cell #" + indexPath.row.description
        return cell
    }
}

extension SearchListController: UITableViewDelegate {
    
}

extension SearchListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        fatalError("Abstract method was called")
    }
}
