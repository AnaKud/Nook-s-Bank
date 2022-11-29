// AlertColors.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct Alert {
		let backgroundColor: UIColor
		let borderColor: CGColor

		init(_ screen: Screen?) {
			let colorType = ColorType(screen ?? .mainScreen(.additionalScreen))
			self.init(colorType)
		}

		init(_ screenType: ScreenType?) {
			let colorType = ColorType(screenType ?? .additionalScreen)
			self.init(colorType)
		}

		init(_ loginedScreenType: LoginedScreenType?) {
			let colorType = ColorType(loginedScreenType ?? .miles)
			self.init(colorType)
		}

		private init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.backgroundColor = PurpleColor.darkColor.color
				self.borderColor = PurpleColor.darknestColor.cgColor
			case .pink:
				self.backgroundColor = PinkColor.lightColor.color
				self.borderColor = PinkColor.darknestColor.cgColor
			case .green:
				self.backgroundColor = GreenColor.darkColor.color
				self.borderColor = GreenColor.darknestColor.cgColor
			case .blue:
				self.backgroundColor = BlueColor.darkColor.color
				self.borderColor = BlueColor.darknestColor.cgColor
			case .gray:
				self.backgroundColor = GrayColor.mediumColor.color
				self.borderColor = GrayColor.darknestColor.cgColor
			}
		}
	}
}
