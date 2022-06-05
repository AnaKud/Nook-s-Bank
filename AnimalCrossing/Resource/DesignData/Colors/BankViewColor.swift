// BankViewColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct BankViewColor {
		let backgroundViewColor: UIColor?
		let titleTextColor: UIColor?
		let itemTextColor: UIColor?
		let expenseLabelColor: UIColor?
		let incomeLabelColor: UIColor?

		init(_ screen: Screen?) {
			let colorType = ColorType(screen ?? .mainScreen(.logined(.main)))
			self.init(colorType)
		}

		init(_ screenType: ScreenType?) {
			let colorType = ColorType(screenType ?? .logined(.main))
			self.init(colorType)
		}

		private init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.backgroundViewColor = PurpleColor.lightColor.color
				self.titleTextColor = PurpleColor.darkColor.color
				self.itemTextColor = PurpleColor.darknestColor.color
				self.expenseLabelColor = PurpleColor.negativeAccentColor.color
				self.incomeLabelColor = PurpleColor.positiveAccentColor.color
			case .gray:
				self.backgroundViewColor = GrayColor.lightColor.color
				self.titleTextColor = GrayColor.darknestColor.color
				self.itemTextColor = GrayColor.darkColor.color
				self.expenseLabelColor = GrayColor.negativeAccentColor.color
				self.incomeLabelColor = GrayColor.positiveAccentColor.color
			case .pink:
				self.backgroundViewColor = PinkColor.lightColor.color
				self.titleTextColor = PinkColor.darknestColor.color
				self.itemTextColor = PinkColor.darkColor.color
				self.expenseLabelColor = PinkColor.negativeAccentColor.color
				self.incomeLabelColor = PinkColor.positiveAccentColor.color
			case .green:
				self.backgroundViewColor = GreenColor.lightColor.color
				self.titleTextColor = GreenColor.darknestColor.color
				self.itemTextColor = GreenColor.darkColor.color
				self.expenseLabelColor = GreenColor.negativeAccentColor.color
				self.incomeLabelColor = GreenColor.positiveAccentColor.color
			case .blue:
				self.backgroundViewColor = BlueColor.lightColor.color
				self.titleTextColor = BlueColor.darkColor.color
				self.itemTextColor = BlueColor.darknestColor.color
				self.expenseLabelColor = BlueColor.negativeAccentColor.color
				self.incomeLabelColor = BlueColor.positiveAccentColor.color
			}
		}
	}
}
