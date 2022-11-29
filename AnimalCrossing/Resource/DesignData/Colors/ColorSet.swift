// ColorSet.swift
// Created by Anastasiya Kudasheva on 04.12.2021

import UIKit

struct ColorSet {
	private(set) var cellColorSet: CellColor
	private(set) var textfieldColor: TextFieldColor
	private(set) var circleViewColor: CircleViewColor
	private(set) var ovalButtonColor: OvalButtonColor
	private(set) var mainViewColor: MainViewColor
	private(set) var activityIndicatorColor: ActivityIndicatorColor
	private(set) var bankViewColor: BankViewColor
	private(set) var passCodeColor: PassCodeViewColor
	private(set) var segmentedControlColor: SegmentedControlColor
	private(set) var switchColor: SwitchColor

	init(for screen: Screen?) {
		let screenType = screen ?? .mainScreen(.additionalScreen)
		let colorType = ColorType(screenType)
		self.cellColorSet = CellColor(screenType)
		self.textfieldColor = TextFieldColor(screenType)
		self.circleViewColor = CircleViewColor(screenType)
		self.ovalButtonColor = OvalButtonColor(screenType)
		self.mainViewColor = MainViewColor(colorType)
		self.activityIndicatorColor = ActivityIndicatorColor(colorType)
		self.bankViewColor = BankViewColor(screen)
		self.passCodeColor = PassCodeViewColor()
		self.segmentedControlColor = SegmentedControlColor(screenType)
		self.switchColor = SwitchColor(colorType)
	}

	init(for screenType: ScreenType?) {
		let screenType = screenType ?? .additionalScreen
		let colorType = ColorType(screenType)
		self.cellColorSet = CellColor(screenType)
		self.textfieldColor = TextFieldColor(screenType)
		self.circleViewColor = CircleViewColor(screenType)
		self.ovalButtonColor = OvalButtonColor(screenType)
		self.mainViewColor = MainViewColor(colorType)
		self.activityIndicatorColor = ActivityIndicatorColor(colorType)
		self.bankViewColor = BankViewColor(screenType)
		self.passCodeColor = PassCodeViewColor()
		self.segmentedControlColor = SegmentedControlColor(screenType)
		self.switchColor = SwitchColor(colorType)
	}
}
