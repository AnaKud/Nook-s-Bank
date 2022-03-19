// CustomAlertController.swift
// Created by Anastasiya Kudasheva on 11.06.2021.

import UIKit

class CustomAlertController: UIAlertController {
	private var color = ColorSet.Alert(for: nil)

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = self.color.backgroundColor
		self.view.layer.cornerRadius = 15
		self.view.layer.borderWidth = 3
		self.view.layer.borderColor = self.color.borderColor
	}

	func changeAlertColors(for screenType: ScreenTypes?) {
		self.color = ColorSet.Alert(for: screenType)
	}
}
