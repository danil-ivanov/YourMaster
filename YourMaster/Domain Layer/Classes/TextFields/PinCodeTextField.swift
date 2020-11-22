//
//  PinCodeTextField.swift
//  YourMaster
//
//  Created by Maxim Egorov on 14.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import Foundation
import UIKit

final class PinCodeTextField: UITextField {
    private let pieces = 4
    private let spacing: CGFloat = 10
    private var sectionWidth: CGFloat {
        return bounds.width / 4.0
    }
    
    private var charSize: CGSize {
        SFUIDisplay.bold.sizeOfChar(with: 18)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: (sectionWidth)/2 + spacing/2 - charSize.width, bottom: 0, right: -50))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: (sectionWidth)/2 + spacing/2 - charSize.width, bottom: 0, right: -50))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = SFUIDisplay.bold.font(size: 18)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        font = SFUIDisplay.bold.font(size: 18)
    }
    
    func applyStyles() {
        self.apply(.pinStyle(spacing: sectionWidth - charSize.width))
        self.apply(.underlineStyle(pieces: pieces, spacing: spacing, height: 2, color: .gray))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyles()
    }
}
