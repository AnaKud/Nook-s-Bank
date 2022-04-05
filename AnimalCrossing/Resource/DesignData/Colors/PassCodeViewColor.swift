// PassCodeViewColor.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

extension ColorSet {
	struct PassCodeViewColor {
		let backgroundColor: UIColor?
		let textColor: UIColor?
		let pinColor: UIColor?
		let pinBorderColor: CGColor?
		let buttonBorderColor: CGColor?
		let buttonTappedBgColor: CGColor?
		let buttonBgColor: CGColor?
		let buttonNumberColor: UIColor?

		init() {
			self.backgroundColor = GreenColor.lightColor.color
			self.textColor = GreenColor.darknestColor.color
			self.pinColor = GreenColor.darkColor.color
			self.pinBorderColor = GreenColor.darkColor.cgColor
			self.buttonBorderColor = GreenColor.darkColor.cgColor
			self.buttonTappedBgColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 0.1942777318)
			self.buttonBgColor = GreenColor.lightColor.cgColor
			self.buttonNumberColor = GreenColor.darkColor.color
		}
	}
}
