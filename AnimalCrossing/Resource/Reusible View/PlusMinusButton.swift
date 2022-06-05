// PlusMinusButton.swift
// Created by Anastasiya Kudasheva on 20.03.2022

import UIKit

class PlusMinusButton: UIButton {
	private let expenceType: OperationType
	private let screenType: ScreenType
	private var buttonImage: UIImage?

	init(expenceType: OperationType, screenType: ScreenType) {
		self.expenceType = expenceType
		self.screenType = screenType
		super.init(frame: .zero)
		self.loadImage()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension PlusMinusButton {
	func loadImage() {
		switch self.screenType {
		case .logined(let loginedScreenType): self.loadImageForLogginedScreen(loginedScreenType)
		case .unlogined, .additionalScreen: self.loadImageForUnlogginedScreen()
		}
		self.setImage(self.buttonImage, for: .normal)
	}

	func loadImageForLogginedScreen(_ loginedScreenType: LoginedScreenType) {
//		switch loginedScreenType {
//		case .main, .bells:
//			<#code#>
//		case .loan:
//			<#code#>
//		case .poki:
//			<#code#>
//		case .miles:
//			<#code#>
//		}
		switch self.expenceType {
		case .plus:
			self.buttonImage = UIImage(named: AppImage.Bank.plusBells.rawValue)
		case .minus:
			self.buttonImage = UIImage(named: AppImage.Bank.minusBells.rawValue)
		}
	}

	func loadImageForUnlogginedScreen() {
		switch self.expenceType {
		case .plus:
			self.buttonImage = UIImage(named: AppImage.Bank.plusUnlogin.rawValue)
		case .minus:
			self.buttonImage = UIImage(named: AppImage.Bank.minusUnlogin.rawValue)
		}
	}
}
