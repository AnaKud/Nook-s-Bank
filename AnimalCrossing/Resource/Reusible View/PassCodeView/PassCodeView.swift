// PassCodeView.swift
// Created by Anastasiya Kudasheva on 14.07.2021.

import UIKit

class PassCodeView: UIView, UITextInputTraits {
	var endEditing: Bool {
		self.code.count == self.maxLength
	}

	var code: String = "" {
		didSet {
			self.updateStack(by: code)
		}
	}

	override var canBecomeFirstResponder: Bool {
		return false
	}

	private let maxLength = AppContraints.PinPadLogin.maxPasswordLength
	private let colorSet = ColorSet.PassCodeViewColor(for: .other)
	private let stack = UIStackView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupPins()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func clearPins() {
		if self.hasText {
			self.code.removeAll()
		}
	}
}

private extension PassCodeView {
	func setupPins() {
		self.addSubview(self.stack)

		self.stack.snp.makeConstraints { make in
			make.width.equalTo(AppContraints.PinPadLogin.passCodeWidth)
		}
		self.backgroundColor = self.colorSet.backgroundColor
		self.stack.axis = .horizontal
		self.stack.distribution = .fillProportionally
		self.updateStack(by: self.code)
	}

	func updateStack(by code: String) {
		var emptyPins: [UIView] = Array(0..<maxLength).map { _ in self.emptyPin() }
		let userPinLength = code.count
		let pins: [UIView] = Array(0..<userPinLength).map { _ in self.pin() }

		for (index, element) in pins.enumerated() {
			emptyPins[index] = element
		}
		self.stack.removeAllArrangedSubViews()
		for view in emptyPins {
			self.stack.addArrangedSubview(view)
		}
	}

	func emptyPin() -> UIView { return Pin() }

	func pin() -> UIView {
		let pin = Pin()
		pin.fillBackground()
		return pin
	}
}

extension PassCodeView: UIKeyInput {
	var hasText: Bool {
		return !self.code.isEmpty
	}

	func insertText(_ text: String) {
		if self.code.count == self.maxLength {
			return
		}
		self.code.append(contentsOf: text)
	}

	func deleteBackward() {
		if self.hasText {
			self.code.removeLast()
		}
	}
}
