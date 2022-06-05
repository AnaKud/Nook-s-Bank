// TextFieldColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct TextFieldColor {
		private(set) var backgroundColor: UIColor?
		private(set) var uneditableBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		private(set) var borderColor: CGColor?
		private(set) var textColor: UIColor?
		private(set) var imageColor: UIColor?

		init(_ screen: Screen) {
			switch screen {
			case .mainScreen(let screenType):
				self.init(screenType)
			case .loginScreen:
				self.init(for: .gray)
				self.backgroundColor = PurpleColor.lightColor.color
				self.borderColor = PurpleColor.darknestColor.cgColor
				self.textColor = PurpleColor.darkColor.color
				self.imageColor = PurpleColor.darkColor.color
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
				self.backgroundColor = PurpleColor.lightestColor.color
				self.borderColor = PurpleColor.darknestColor.cgColor
				self.textColor = PurpleColor.darkColor.color
				self.imageColor = PurpleColor.darkColor.color
			case .gray:
				self.backgroundColor = GrayColor.lightestColor.color
				self.borderColor = GrayColor.darknestColor.cgColor
				self.textColor = GrayColor.darkColor.color
				self.imageColor = GrayColor.darkColor.color
			case .pink:
				self.backgroundColor = PinkColor.lightestColor.color
				self.borderColor = PinkColor.darknestColor.cgColor
				self.textColor = PinkColor.darkColor.color
				self.imageColor = PinkColor.darkColor.color
			case .green:
				self.backgroundColor = GreenColor.lightestColor.color
				self.borderColor = GreenColor.darknestColor.cgColor
				self.textColor = GreenColor.darkColor.color
				self.imageColor = GreenColor.darkColor.color
			case .blue:
				self.backgroundColor = BlueColor.lightestColor.color
				self.borderColor = BlueColor.darknestColor.cgColor
				self.textColor = BlueColor.darkColor.color
				self.imageColor = BlueColor.darkColor.color
			}
		}
	}
}
