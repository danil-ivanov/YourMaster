//
//  ImpactFeedbackGenerator.swift
//  YourMaster
//
//  Created by Maxim Egorov on 09.11.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

struct ImpactFeedbackGenerator {
    private static let generator = UIImpactFeedbackGenerator(style: .medium)
    
    static func impactOccured() {
        generator.impactOccurred()
    }
}
