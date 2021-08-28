//
//  PassCodeView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 14.07.2021.
//

import UIKit

class PassCodeView: UIView, UITextInputTraits {
	var endEditing = false
	var code: String = "" {
        didSet {
			self.updateStack(by: code)
        }
    }

	let maxLength = AppContraints.PinPadLogin.maxPasswordLength
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

    override var canBecomeFirstResponder: Bool {
        return false
    }

    private func setupPins() {
		self.addSubview(self.stack)

		self.stack.snp.makeConstraints { make in
			make.width.equalTo(AppContraints.PinPadLogin.passCodeWidth)
		}
		self.backgroundColor = self.colorSet.backgroundColor
		self.stack.axis = .horizontal
		self.stack.distribution = .fillProportionally
		self.updateStack(by: self.code)
    }

    private func updateStack(by code: String) {
        var emptyPins: [UIView] = Array(0..<maxLength).map { _ in emptyPin() }
        let userPinLength = code.count
        let pins: [UIView] = Array(0..<userPinLength).map { _ in pin() }

        for (index, element) in pins.enumerated() {
            emptyPins[index] = element
        }
		self.stack.removeAllArrangedSubViews()
        for view in emptyPins {
			self.stack.addArrangedSubview(view)
        }
    }

    private func emptyPin() -> UIView {
        return Pin()
    }

    private func pin() -> UIView {
        let pin = Pin()
        pin.pin.backgroundColor = colorSet.pinColor
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
		if self.code.count == self.maxLength {
			self.endEditing = true
		}
        print(text)
    }

    func deleteBackward() {
		if self.hasText {
			self.code.removeLast()
			if self.endEditing == true {
				self.endEditing = false
			}
            print("text deleted")
        }
    }
}

class Pin: UIView {
	let pin = UIView()
	private let colorSet = ColorSet.PassCodeViewColor(for: .other)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPin()
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPin() {
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

extension UIStackView {
    func removeAllArrangedSubViews() {
        let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
