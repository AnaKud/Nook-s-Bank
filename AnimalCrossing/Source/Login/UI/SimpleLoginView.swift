// SimpleLoginView.swift
// Created by Anastasiya Kudasheva on 26.08.2021.

import UIKit

class SimpleLoginView: UIView {
	private var callBack: UISimpleLoginViewCallBack?
	private let controllerTitle: String
	private let colors = ColorSet(for: .loginScreen(.simple))

	private let titleLabel = UILabel()
	private let pinView = PassCodeView()
	private lazy var oneButton = self.makePadButton(with: .one)
	private lazy var twoButton = self.makePadButton(with: .two)
	private lazy var threeButton = self.makePadButton(with: .three)
	private lazy var fourButton = self.makePadButton(with: .four)
	private lazy var fiveButton = self.makePadButton(with: .five)
	private lazy var sixButton = self.makePadButton(with: .six)
	private lazy var sevenButton = self.makePadButton(with: .seven)
	private lazy var eightButton = self.makePadButton(with: .eight)
	private lazy var nineButton = self.makePadButton(with: .nine)
	private lazy var zeroButton = self.makePadButton(with: .zero)
	private lazy var backspaceButton = self.makeAdditionalKeyboardButton(with: AppImage.Login.back.image)
	private lazy var faceIdButton = self.makeAdditionalKeyboardButton(with: AppImage.PinPad.authImage.image)
	private lazy var forgetPasswordButton = OvalButton(withTitle: AppTitle.PassCode.forgetTitle,
													   width: AppContraints.Login.widthForgetButton,
													   height: AppContraints.Login.heightButtons,
													   color: self.colors)

	init(controllerTitle: String) {
		self.controllerTitle = controllerTitle
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupCallBack(_ callBack: UISimpleLoginViewCallBack?) {
		self.callBack = callBack
	}

	func clearPinView() {
		self.pinView.clearPins()
	}
}

// MARK: - General Views
private extension SimpleLoginView {
	func loadUI() {
		self.setupTitleLabel()
		self.setupPinView()
		self.setupPadView()
		self.addActionForButtons()
	}

	func setupTitleLabel() {
		self.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.addSubview(self.titleLabel)
		self.titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self).offset(AppContraints.Login.loginMinVerticalEdge)
			make.leading.trailing.equalTo(self)
		}
		self.titleLabel.textColor = self.colors.mainViewColor.textColor
		self.titleLabel.numberOfLines = 0
		self.titleLabel.text = self.controllerTitle
		self.titleLabel.textAlignment = .center
		self.titleLabel.font = ACFont.controllerTitleFont.font
	}

	func setupPinView() {
		self.addSubview(self.pinView)
		self.pinView.snp.makeConstraints { make in
			make.top.equalTo(self.titleLabel.snp.bottom).offset(AppContraints.minEdge)
			make.centerX.equalTo(self)
			make.width.equalTo(AppContraints.PinPadLogin.passCodeWidth)
			make.height.equalTo(AppContraints.PinPadLogin.pinSize)
		}
		self.pinView.becomeFirstResponder()
	}

	func setupPadView() {
		self.setupFirstPadRow()
		self.setupSecondPadRow()
		self.setupThirdPadRow()
		self.setupFourthPadRow()
		self.setupFifthPadRow()
	}
}

// MARK: - Pad Row Views
private extension SimpleLoginView {
	func setupFirstPadRow() {
		self.addSubview(self.twoButton)
		self.twoButton.snp.makeConstraints { make in
			make.top.equalTo(self.pinView.snp.bottom).offset(AppContraints.navTitle)
			make.centerX.equalTo(self)
		}
		self.addSubview(self.oneButton)
		self.oneButton.snp.makeConstraints { make in
			make.top.equalTo(pinView.snp.bottom).offset(AppContraints.navTitle)
			make.trailing.equalTo(twoButton.snp.leading).offset(-AppContraints.standartEdge)
		}
		self.addSubview(self.threeButton)
		self.threeButton.snp.makeConstraints { make in
			make.top.equalTo(pinView.snp.bottom).offset(AppContraints.navTitle)
			make.leading.equalTo(twoButton.snp.trailing).offset(AppContraints.standartEdge)
		}
	}

	func setupSecondPadRow() {
		self.addSubview(self.fourButton)
		self.fourButton.snp.makeConstraints { make in
			make.leading.equalTo(self.oneButton)
			make.top.equalTo(self.oneButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.addSubview(self.fiveButton)
		self.fiveButton.snp.makeConstraints { make in
			make.leading.equalTo(self.twoButton)
			make.top.equalTo(self.twoButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.addSubview(self.sixButton)
		self.sixButton.snp.makeConstraints { make in
			make.leading.equalTo(self.threeButton)
			make.top.equalTo(self.threeButton.snp.bottom).offset(AppContraints.standartEdge)
		}
	}

	func setupThirdPadRow() {
		self.addSubview(self.sevenButton)
		self.sevenButton.snp.makeConstraints { make in
			make.leading.equalTo(self.oneButton)
			make.top.equalTo(fourButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.addSubview(self.eightButton)
		self.eightButton.snp.makeConstraints { make in
			make.leading.equalTo(self.fiveButton)
			make.top.equalTo(self.fiveButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.addSubview(self.nineButton)
		self.nineButton.snp.makeConstraints { make in
			make.leading.equalTo(self.sixButton)
			make.top.equalTo(self.sixButton.snp.bottom).offset(AppContraints.standartEdge)
		}
	}

	func setupFourthPadRow() {
		self.addSubview(self.zeroButton)
		self.zeroButton.snp.makeConstraints { make in
			make.leading.equalTo(self.eightButton)
			make.top.equalTo(self.eightButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.addSubview(self.faceIdButton)
		self.faceIdButton.snp.makeConstraints { make in
			make.leading.equalTo(self.sevenButton)
			make.top.equalTo(self.sevenButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.addSubview(self.backspaceButton)
		self.backspaceButton.snp.makeConstraints { make in
			make.leading.equalTo(self.nineButton)
			make.top.equalTo(self.nineButton.snp.bottom).offset(AppContraints.standartEdge)
		}
	}

	func setupFifthPadRow() {
		self.addSubview(self.forgetPasswordButton)
		self.forgetPasswordButton.snp.makeConstraints { make in
			make.centerX.equalTo(self)
			make.top.equalTo(self.zeroButton.snp.bottom).offset(AppContraints.midEdge)
		}
	}
}

// MARK: - Subviews settings
private extension SimpleLoginView {
	func addActionForButtons() {
		self.oneButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.twoButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.threeButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.fourButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.fiveButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.sixButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.sevenButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.eightButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.nineButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.zeroButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)

		self.faceIdButton.addTarget(self, action: #selector(self.faceIdButtonTapped), for: .touchUpInside)
		self.backspaceButton.addTarget(self, action: #selector(self.backspaceButtonTapped), for: .touchUpInside)
		self.forgetPasswordButton.addTarget(self, action: #selector(self.forgetPasswordButtonTapped), for: .touchUpInside)
	}

	func buttonsAnimation(for button: UIButton) {
		UIButton.animate(withDuration: 0.001,
						 delay: 0,
						 usingSpringWithDamping: 1,
						 initialSpringVelocity: 1,
						 options: .curveEaseInOut) { [ weak self ] in
			button.layer.backgroundColor = self?.colors.passCodeColor.buttonTappedBgColor
		}
		UIButton.animate(withDuration: 0.01,
						 delay: 0.1,
						 usingSpringWithDamping: 1,
						 initialSpringVelocity: 1,
						 options: .curveEaseInOut) { [ weak self ] in
			button.layer.backgroundColor = self?.colors.passCodeColor.buttonBgColor
		}
	}
}

// MARK: - Subviews creation
private extension SimpleLoginView {
	func makePadButton(with title: PadKeyBoard) -> UIButton {
		let button = UIButton()
		button.snp.makeConstraints { make in
			make.width.height.equalTo(AppContraints.PinPadLogin.padSize)
		}
		button.layer.backgroundColor = self.colors.passCodeColor.buttonBgColor
		button.layer.cornerRadius = AppContraints.PinPadLogin.padCorner
		button.layer.borderWidth = AppContraints.PinPadLogin.padBorder
		button.layer.borderColor = self.colors.passCodeColor.buttonBorderColor
		button.layer.masksToBounds = true
		button.tag = Int(title.rawValue) ?? -1
		let label = UILabel()
		button.addSubview(label)
		label.snp.makeConstraints { make in
			make.leading.top.equalTo(button).offset(-5)
			make.trailing.bottom.equalTo(button)
		}
		label.text = title.rawValue
		label.textAlignment = .center
		label.font = ACFont.padFont.font
		label.textColor = self.colors.passCodeColor.buttonNumberColor

		return button
	}

	func makeAdditionalKeyboardButton(with image: UIImage?) -> UIButton {
		let button = UIButton()
		button.snp.makeConstraints { make in
			make.width.height.equalTo(AppContraints.PinPadLogin.padSize)
		}
		button.layer.backgroundColor = self.colors.passCodeColor.buttonBgColor

		let imageView = UIImageView()
		imageView.image = image
		imageView.tintColor = self.colors.passCodeColor.buttonNumberColor
		button.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.leading.top.equalTo(button).offset(AppContraints.standartEdge)
			make.trailing.bottom.equalTo(button).offset(-AppContraints.standartEdge)
		}
		return button
	}
}

// MARK: - Objc actions
@objc
private extension SimpleLoginView {
	func numberButtonTapped(sender: UIButton) {
		self.buttonsAnimation(for: sender)
		guard sender.tag != -1 else { return }
		self.pinView.insertText("\(sender.tag)")
		if self.pinView.endEditing == true {
			self.callBack?.pinEndEditing(pin: self.pinView.code)
		}
	}

	func faceIdButtonTapped(sender: UIButton) {
		self.callBack?.touchIdButtonTapped()
	}

	func backspaceButtonTapped(sender: UIButton) {
		self.pinView.deleteBackward()
	}

	func forgetPasswordButtonTapped(sender: UIButton) {
		self.callBack?.forgetPadButtonTapped()
	}
}
