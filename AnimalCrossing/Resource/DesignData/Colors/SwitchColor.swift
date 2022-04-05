// SwitchColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct SwitchColor {
		let borderColor: CGColor?
		let backgroundColor: UIColor?
		let thumbTintColor: UIColor?
		let onTintColor: UIColor?

		init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.borderColor = PurpleColor.darkColor.cgColor
				self.backgroundColor = PurpleColor.lightestColor.color
				self.thumbTintColor = PurpleColor.darknestColor.color
				self.onTintColor = PurpleColor.mediumColor.color
			case .gray:
				self.borderColor = GrayColor.darknestColor.cgColor
				self.backgroundColor = GrayColor.lightestColor.color
				self.thumbTintColor = GrayColor.darknestColor.color
				self.onTintColor = GrayColor.mediumColor.color
			case .pink:
				self.borderColor = PinkColor.darknestColor.cgColor
				self.backgroundColor = PinkColor.lightestColor.color
				self.thumbTintColor = PinkColor.darknestColor.color
				self.onTintColor = PinkColor.mediumColor.color
			case .green:
				self.borderColor = GreenColor.darknestColor.cgColor
				self.backgroundColor = GreenColor.lightestColor.color
				self.thumbTintColor = GreenColor.darkColor.color
				self.onTintColor = GreenColor.lightColor.color
			case .blue:
				self.borderColor = BlueColor.darkColor.cgColor
				self.backgroundColor = BlueColor.lightestColor.color
				self.thumbTintColor = BlueColor.darknestColor.color
				self.onTintColor = BlueColor.mediumColor.color
			}
		}
	}
}
