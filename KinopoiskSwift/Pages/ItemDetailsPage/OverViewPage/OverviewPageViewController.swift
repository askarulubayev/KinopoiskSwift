//
//  OverviewPageViewController.swift
//  KinopoiskSwift
//
//  Created by Аскар on 9/28/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class OverviewPageViewController: BaseTableViewController {
    
    private let overviewText: String
    
    init(overviewText: String) {
        self.overviewText = overviewText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylizeViews()
    }
}

extension OverviewPageViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OverviewTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.set(overview: overviewText)
        return cell
    }
}

extension OverviewPageViewController {
    private func stylizeViews() {
        tableView.sectionHeaderHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.register(OverviewTVCell.self)
        tableView.backgroundColor = AppColor.whitish.uiColor
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
}
