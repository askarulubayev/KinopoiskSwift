//
//  PageControl.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/20/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class PageControl: UIView {
    
    private let stackView = UIStackView()
    private let pageControlItemMaxWidth: CGFloat = 4.3
    private let constantHeight: CGFloat = 8.0
    
    var currentPageIndicatorTintColor = UIColor.lightGray
    var pageIndicatorTintColor = UIColor.darkGray
    
    var currentPage: Int = 0 {
        didSet {
            if !stackView.arrangedSubviews.isEmpty && stackView.arrangedSubviews.count > currentPage {
                stackView.arrangedSubviews[currentPage].backgroundColor = currentPageIndicatorTintColor
            }
        }
        willSet {
            if !stackView.arrangedSubviews.isEmpty && stackView.arrangedSubviews.count > currentPage {
                stackView.arrangedSubviews[currentPage].backgroundColor = pageIndicatorTintColor
            }
        }
    }
    
    var numberOfPages: Int = 0 {
        didSet {
            hideForSinglePage()
            setupPageViews()
        }
    }
    
    override var bounds: CGRect {
        didSet { setupPageViews() }
    }
    
    var shouldHideSingleIndicator: Bool = false {
        didSet { hideForSinglePage() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stylize()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func stylize() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        addSubview(stackView)
    }
    
    private func setViewConstraints() {
        heightAnchor.constraint(equalToConstant: constantHeight)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraints = [
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    private func setupPageViews() {
        guard numberOfPages > 0 && frame.width > 0 else {
            isHidden = true
            return
        }
        hideForSinglePage()
        clearStackView()
        fillStackView()
        setCurrentPageIndicator()
    }
    
    private func fillStackView() {
        stackView.spacing = getPageControlWidth()
        for _ in 0..<numberOfPages {
            stackView.addArrangedSubview(getIndicatorView(withWidth: getPageControlWidth()))
        }
    }
    
    private func getIndicatorView(withWidth width: CGFloat) -> UIView {
        let view = UIView()
        
        view.backgroundColor = pageIndicatorTintColor
        view.layer.cornerRadius = width / 2
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraints = [
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: width)
        ]
        NSLayoutConstraint.activate(layoutConstraints)
        return view
    }
    
    private func setCurrentPageIndicator() {
        if numberOfPages > currentPage {
            stackView.arrangedSubviews[currentPage].backgroundColor = currentPageIndicatorTintColor
        }
    }
    
    private func hideForSinglePage() {
        isHidden = numberOfPages <= 1 && shouldHideSingleIndicator
    }
    
    private func clearStackView() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    private func getPageControlWidth() -> CGFloat {
        let ratio = frame.width / CGFloat(numberOfPages)
        return min(pageControlItemMaxWidth, ratio / 2)
    }
}
