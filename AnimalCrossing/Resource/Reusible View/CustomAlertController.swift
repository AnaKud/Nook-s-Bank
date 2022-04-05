// CustomAlertController.swift
// Created by Anastasiya Kudasheva on 11.06.2021.

import UIKit

class CustomAlertController: UIAlertController {
	private var color = ColorSet.Alert(.mainScreen(.additionalScreen))

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = self.color.backgroundColor
		self.view.layer.cornerRadius = 15
		self.view.layer.borderWidth = 3
		self.view.layer.borderColor = self.color.borderColor
	}

	func changeAlertColors(for screen: Screen?) {
		self.color = ColorSet.Alert(screen)
	}

	func changeAlertColors(for screenType: ScreenType?) {
		self.color = ColorSet.Alert(screenType)
	}

	func changeAlertColors(for screenType: LoginedScreenType?) {
		self.color = ColorSet.Alert(screenType)
	}
}
