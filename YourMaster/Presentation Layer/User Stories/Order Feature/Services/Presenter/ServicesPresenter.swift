//
//  ServicesPresenter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol ServicesPresenterOutput: AnyObject {
    
}

final class ServicesPresenter {
    weak var view: ServicesViewInput?
    private let output: ServicesPresenterOutput
    
    init(output: ServicesPresenterOutput) {
        self.output = output
    }
}

extension ServicesPresenter: ServicesViewOutput {}

extension ServicesPresenter: ServicesPresenterInput {}
