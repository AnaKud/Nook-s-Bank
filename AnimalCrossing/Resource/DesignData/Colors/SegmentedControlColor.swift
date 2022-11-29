// SegmentedControlColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct SegmentedControlColor {
		let borderColor: CGColor?
		let backgroundColor: UIColor?
		let selectedItemBgColor: UIColor?
		let textColor: UIColor?
		let selectedTextColor: UIColor?

		init(_ screen: Screen?) {
			let colorType = ColorType(screen ?? .mainScreen(.additionalScreen))
			self.init(colorType)
		}

		init(_ screenType: ScreenType?) {
			let colorType = ColorType(screenType ?? .additionalScreen)
			self.init(colorType)
		}

		private init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.borderColor = PurpleColor.darkColor.cgColor
				self.backgroundColor = PurpleColor.mediumColor.color
				self.selectedItemBgColor = PurpleColor.lightColor.color
				self.textColor = PurpleColor.darkColor.color
				self.selectedTextColor = PurpleColor.darknestColor.color
			case .gray:
				self.borderColor = GrayColor.darknestColor.cgColor
				self.backgroundColor = GrayColor.lightestColor.color
				self.selectedItemBgColor = GrayColor.mediumColor.color
				self.textColor = GrayColor.darknestColor.color
				self.selectedTextColor = GrayColor.darknestColor.color
			case .pink:
				self.borderColor = PinkColor.darknestColor.cgColor
				self.backgroundColor = PinkColor.lightColor.color
				self.selectedItemBgColor = PinkColor.lightestColor.color
				self.textColor = PinkColor.darknestColor.color
				self.selectedTextColor = PinkColor.darkColor.color
			case .green:
				self.borderColor = GreenColor.darknestColor.cgColor
				self.backgroundColor = GreenColor.lightColor.color
				self.selectedItemBgColor = #colorLiteral(red: 0.7349590659, green: 0.8215679526, blue: 0.5087055564, alpha: 1)
				self.textColor = GreenColor.darknestColor.color
				self.selectedTextColor = GreenColor.darkColor.color
			case .blue:
				self.borderColor = BlueColor.darkColor.cgColor
				self.backgroundColor = BlueColor.mediumColor.color
				self.selectedItemBgColor = BlueColor.lightColor.color
				self.textColor = BlueColor.darkColor.color
				self.selectedTextColor = BlueColor.darknestColor.color
			}
		}
	}
}
