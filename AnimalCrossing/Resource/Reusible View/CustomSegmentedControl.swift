// CustomSegmentedControl.swift
// Created by Anastasiya Kudasheva on 08.09.2021

import UIKit

class CustomSegmentedControl: UISegmentedControl {
	private var color: ColorSet.SegmentedControlColor

	init(screenType: ScreenType?, items: [Any]?) {
		self.color = ColorSet.SegmentedControlColor(screenType)
		super.init(items: items)
		self.setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {
		self.layer.borderColor = self.color.borderColor
		self.layer.borderWidth = 2

		self.backgroundColor = self.color.backgroundColor
		self.selectedSegmentTintColor = self.color.selectedItemBgColor
		self.setTitleTextAttributes([
			.font: ACFont.defaultBoldFont.font as Any,
			.foregroundColor: self.color.selectedTextColor as Any
		],
									for: .selected)
		self.setTitleTextAttributes([
			.font: ACFont.defaultLightFont.font as Any,
			.foregroundColor: self.color.textColor as Any
		],
									for: .normal)
	}
}
