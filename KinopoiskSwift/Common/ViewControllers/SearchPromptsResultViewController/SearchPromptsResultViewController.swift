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
    
    open var separatorColor: UIColor = UIColor.lightGray {
        didSet {
            self.tableView.separatorColor = separatorColor
        }
    }
    
    open var separatorInset: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.tableView.separatorInset = separatorInset
        }
    }
    
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
        setupKeyboardNotifications()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension SearchPromptsResultViewController {
    @objc func didTapBackground(sender: AnyObject?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let kbSizeValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbHeight: kbSizeValue.cgRectValue.height, duration: kbDurationNumber.doubleValue)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let kbDurationNumber = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbHeight: 0, duration: kbDurationNumber.doubleValue)
    }
}

extension SearchPromptsResultViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.tableView))! {
            return false
        }
        return true
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
        tableView.contentInsetAdjustmentBehavior = .never
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SearchPromptsResultViewController.didTapBackground(sender:)))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        tableView.backgroundColor = .clear
        tableView.register(cellClass, forCellReuseIdentifier: cellIdentier)
        tableView.separatorColor = separatorColor
        tableView.separatorInset = separatorInset
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SearchPromptsResultViewController.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(SearchPromptsResultViewController.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func animateToKeyboardHeight(kbHeight: CGFloat, duration: Double) {
        tableView.contentInset = UIEdgeInsets(top: tableView.contentInset.top, left: 0, bottom: kbHeight, right: 0)
    }
}
