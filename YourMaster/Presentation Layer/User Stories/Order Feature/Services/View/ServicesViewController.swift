//
//  ServicesViewController.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol ServicesViewOutput: AnyObject {
    
}

final class ServicesViewController: UIViewController {
    
    private let output: ServicesViewOutput
    
    init(output: ServicesViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension ServicesViewController: ServicesViewInput {
    
}
