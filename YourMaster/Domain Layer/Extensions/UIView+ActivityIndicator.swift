//
//  UIView+ActivityIndicator.swift
//  YourMaster
//
//  Created by Maxim Egorov on 03.09.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

extension UIView {
    func startLoader() {
        let indicator = ActivityIndicatorView(image: AppAssets.loader!)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        NSLayoutConstraint.activate([indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     indicator.widthAnchor.constraint(equalToConstant: 40),
                                     indicator.heightAnchor.constraint(equalToConstant: 40)])
        indicator.startAnimating()
    }
    
    func startLoader(topOffset: CGFloat) {
        let indicator = ActivityIndicatorView(image: AppAssets.loader!)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        NSLayoutConstraint.activate([indicator.topAnchor.constraint(equalTo: topAnchor, constant: topOffset),
                                     indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     indicator.widthAnchor.constraint(equalToConstant: 40),
                                     indicator.heightAnchor.constraint(equalToConstant: 40)])
        indicator.startAnimating()
    }
    
    func stopLoader() {
        let indicator = subviews.first(where: { $0 is ActivityIndicatorView }) as? ActivityIndicatorView
        indicator?.stopAnimating()
        indicator?.removeFromSuperview()
    }
}
