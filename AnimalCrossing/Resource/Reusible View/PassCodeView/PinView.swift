// PinView.swift
// Created by Anastasiya Kudasheva on 19.03.2022

import UIKit

class Pin: UIView {
	private let pin = UIView()
	private let colorSet = ColorSet.PassCodeViewColor(for: .other)

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupPin()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func fillBackground() {
		self.pin.backgroundColor = self.colorSet.pinColor
	}
}

private extension Pin {
	func setupPin() {
		self.addSubview(self.pin)
		self.pin.snp.makeConstraints { make in
			make.height.width.equalTo(AppContraints.PinPadLogin.pinSize)
		}
		self.pin.layer.cornerRadius = AppContraints.PinPadLogin.pinCorner
		self.pin.layer.borderWidth = AppContraints.PinPadLogin.pinBorder
		self.pin.layer.borderColor = colorSet.pinBorderColor
		self.pin.layer.masksToBounds = true
	}
}
