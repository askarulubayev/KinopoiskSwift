//
//  ViewInstallationProtocol.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

protocol ViewInstallationProtocol {
    func setupViews()
    func addSubviews()
    func setViewConstraints()
    func stylizeViews()
}

extension ViewInstallationProtocol {
    func setupViews() {
        addSubviews()
        setViewConstraints()
        stylizeViews()
    }
}
