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
extension ColorSet {
	struct Alert {
		let backgroundColor: UIColor
		let borderColor: CGColor

		init(for screenType: ScreenTypes?) {
			switch screenType {
			case .unloggined:
				self.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
				self.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
			case .other:
				self.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
				self.borderColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
			default:
				self.backgroundColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.borderColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
			}
		}
	}
}
