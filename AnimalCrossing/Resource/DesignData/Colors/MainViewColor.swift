// MainViewColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct MainViewColor {
		let backgroundColor: UIColor?
		let textColor: UIColor?
		let navigationItemColor: UIColor?

		init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.backgroundColor = PurpleColor.mediumColor.color
				self.textColor = PurpleColor.darkColor.color
				self.navigationItemColor = PurpleColor.darkColor.color
			case .gray:
				self.backgroundColor = GrayColor.lightestColor.color
				self.textColor = GrayColor.darknestColor.color
				self.navigationItemColor = GrayColor.darknestColor.color
			case .pink:
				self.backgroundColor = PinkColor.mediumColor.color
				self.textColor = PinkColor.darkColor.color
				self.navigationItemColor = PinkColor.darkColor.color
			case .green:
				self.backgroundColor = GreenColor.lightColor.color
				self.textColor = GreenColor.darkColor.color
				self.navigationItemColor = GreenColor.darkColor.color
			case .blue:
				self.backgroundColor = BlueColor.mediumColor.color
				self.textColor = BlueColor.darkColor.color
				self.navigationItemColor = BlueColor.darkColor.color
			}
		}
	}
}
