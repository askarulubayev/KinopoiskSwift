//
//  ItemDetailViewContronller.swift
//  KinopoiskSwift
//
//  Created by Аскар on 6/23/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class ItemDetailViewContronller: BaseTableViewController {
    
    private let headerView = ItemDetailHeaderView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 98))
    private let model: TmdbModel
    
    init(model: TmdbModel) {
        self.model = model
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

extension ItemDetailViewContronller {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemDetailOverviewTVCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.set(overview: "")
        return cell
    }
}

extension ItemDetailViewContronller {
    private func stylizeViews() {
        tableView.tableHeaderView = headerView
        tableView.register(ItemDetailOverviewTVCell.self)
        tableView.backgroundColor = AppColor.lightGray.uiColor
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        headerView.set(model: model)
    }
}
