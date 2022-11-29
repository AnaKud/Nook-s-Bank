// OvalButtonColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct OvalButtonColor {
		private(set) var buttonColor: UIColor? = PurpleColor.lightColor.color
		private(set) var buttonTextColor: UIColor? = PurpleColor.darknestColor.color

		init(_ screen: Screen) {
			switch screen {
			case .mainScreen(let screenType):
				self.init(screenType)
			case .loginScreen:
				self.init(for: .gray)
				self.buttonColor = PurpleColor.lightColor.color
				self.buttonTextColor = PurpleColor.darknestColor.color
			}
		}

		init(_ screenType: ScreenType) {
			switch screenType {
			case .unlogined:
				self.init(for: .gray)
			case .logined(let loginedScreenType):
				self.init(for: .init(loginedScreenType))
			case .additionalScreen:
				self.init(for: .green)
			}
		}

		private init(for colorType: ColorType) {
			switch colorType {
			case .purple:
				self.buttonColor = PurpleColor.darkColor.color
				self.buttonTextColor = PurpleColor.lightColor.color
			case .gray:
				self.buttonColor = GrayColor.darknestColor.color
				self.buttonTextColor = GrayColor.lightColor.color
			case .pink:
				self.buttonTextColor = PinkColor.lightColor.color
				self.buttonColor = PinkColor.darkColor.color
			case .green:
				self.buttonTextColor = GreenColor.lightColor.color
				self.buttonColor = GreenColor.darkColor.color
			case .blue:
				self.buttonColor = BlueColor.darkColor.color
				self.buttonTextColor = BlueColor.lightColor.color
			}
		}
	}
}
