//
//  UIView+Extensions.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/30/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

extension UIView {
    func setupDefaultClickAnimation(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions,
                animations: {
                    self.backgroundColor = AppColor.grayClick.uiColor
                }
            )
        }
        else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions,
                animations: {
                    self.backgroundColor = UIColor.white
                }
            )
        }
    }
}
