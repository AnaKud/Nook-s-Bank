// ActivityIndicatorColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct ActivityIndicatorColor {
		let activityColor: UIColor?

		init(_ colorType: ColorType) {
			switch colorType {
			case .purple:
				self.activityColor = PurpleColor.mediumColor.color
			case .gray:
				self.activityColor = GrayColor.mainAccentColor.color
			case .pink:
				self.activityColor = PinkColor.mainAccentColor.color
			case .green:
				self.activityColor = GreenColor.mainAccentColor.color
			case .blue:
				self.activityColor = BlueColor.mainAccentColor.color
			}
		}
	}
}
