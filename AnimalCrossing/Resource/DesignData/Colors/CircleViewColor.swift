// CircleViewColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct CircleViewColor {
		private(set) var circleColor: UIColor?
		private(set) var circleTextColor: UIColor?

		init(_ screen: Screen) {
			switch screen {
			case .mainScreen(let screenType):
				self.init(screenType)
			case .loginScreen:
				self.init(.gray)
				self.circleColor = PurpleColor.darknestColor.color
				self.circleTextColor = PurpleColor.lightColor.color
			}
		}

		init(_ screenType: ScreenType) {
			switch screenType {
			case .additionalScreen:
				self.init(.green)
			case .unlogined:
				self.init(.gray)
			case .logined(let loginedScreenType):
				self.init(.init(loginedScreenType))
			}
		}

		private init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.circleColor = PurpleColor.lightestColor.color
				self.circleTextColor = PurpleColor.darkColor.color
			case .gray:
				self.circleColor = GrayColor.lightColor.color
				self.circleTextColor = GrayColor.darknestColor.color
			case .pink:
				self.circleColor = PinkColor.lightColor.color
				self.circleTextColor = PinkColor.darkColor.color
			case .green:
				self.circleColor = GreenColor.lightColor.color
				self.circleTextColor = GreenColor.darkColor.color
			case .blue:
				self.circleColor = BlueColor.lightestColor.color
				self.circleTextColor = BlueColor.darkColor.color
			}
		}
	}
}
