// CellColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct CellColor {
		let backgroundViewColor: UIColor?
		let topViewColor: UIColor?
		let accentColor: UIColor?
		let titleTextColor: UIColor?
		let itemTextColor: UIColor?

		init(_ screen: Screen) {
			let colorType = ColorType(screen)
			self.init(colorType)
		}

		init(_ screenType: ScreenType) {
			let colorType = ColorType(screenType)
			self.init(colorType)
		}

		private init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.backgroundViewColor = PurpleColor.lightColor.color
				self.topViewColor = PurpleColor.darkColor.color
				self.accentColor = PurpleColor.mediumColor.color
				self.titleTextColor = PurpleColor.lightColor.color
				self.itemTextColor = PurpleColor.darknestColor.color
			case .gray:
				self.backgroundViewColor = GrayColor.lightColor.color
				self.topViewColor = GrayColor.darkColor.color
				self.accentColor = GrayColor.lightestColor.color
				self.titleTextColor = GrayColor.lightColor.color
				self.itemTextColor = GrayColor.darknestColor.color
			case .pink:
				self.backgroundViewColor = PinkColor.lightestColor.color
				self.topViewColor = PinkColor.darkColor.color
				self.accentColor = PinkColor.lightColor.color
				self.titleTextColor = PinkColor.lightestColor.color
				self.itemTextColor = PinkColor.darknestColor.color
			case .green:
				self.backgroundViewColor = GreenColor.lightestColor.color
				self.topViewColor = GreenColor.darkColor.color
				self.accentColor = GreenColor.lightColor.color
				self.titleTextColor = GreenColor.lightestColor.color
				self.itemTextColor = GreenColor.darknestColor.color
			case .blue:
				self.backgroundViewColor = BlueColor.lightColor.color
				self.topViewColor = BlueColor.darkColor.color
				self.accentColor = BlueColor.mediumColor.color
				self.titleTextColor = BlueColor.lightColor.color
				self.itemTextColor = BlueColor.darknestColor.color
			}
		}
	}
}
