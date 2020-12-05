//
//  MenuCell.swift
//  YourMaster
//
//  Created by Александр Пономарёв on 02.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

class MenuCell: TableCell {
	
	@IBOutlet var menuLabel: UILabel!
	
	override class var cellIdentifier: String {
		return String.className(self)
	}

	override func setupView() {
		
	}
	
	override func updateViews() {
		
	}
}
