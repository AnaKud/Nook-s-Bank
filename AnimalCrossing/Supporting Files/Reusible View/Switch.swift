//
//  CustomSwitch.swift
//  Created by Anastasiya Kudasheva on 11.09.2021

import UIKit

class CustomSwitcher: UISwitch {
	var color: ColorSet.SwitchColor
	init(color: ColorSet) {
		self.color = color.switchColor
		super.init(frame: .zero)
		self.setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupUI() {
		self.backgroundColor = self.color.backgroundColor
		self.onTintColor = self.color.onTintColor
		self.thumbTintColor = self.color.thumbTintColor
		self.layer.borderColor = self.color.borderColor
		self.layer.borderWidth = AppContraints.defaultBorder
		self.layer.cornerRadius = self.bounds.height / 2
		self.layer.masksToBounds = true
	}
}
