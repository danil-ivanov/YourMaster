//
//  ReviewsPresenterInput.swift
//  YourMaster
//
//  Created by Maxim Egorov on 20.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

protocol ReviewsPresenterInput: AnyObject {
    func presentReviews(reviews: [Review])
}
