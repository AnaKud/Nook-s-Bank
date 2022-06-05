// TapBarColor.swift
// Created by Anastasiya Kudasheva on 19.03.2022

import UIKit
import SwiftUI

struct TapBarColor {
	let selectedColor: UIColor?
	let unselectedColor: UIColor?

	init(for screenType: ScreenType) {
		switch screenType {
		case .unlogined, .additionalScreen:
			self.selectedColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
			self.unselectedColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
		case .logined:
			self.selectedColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
			self.unselectedColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
		}
	}
}

struct GraphColors {
	static let backgroundColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
	static let gradientStart = Color(#colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1))
	static let gradientStop = Color(#colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1))
}
