//
//  SimpleLoginView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 26.08.2021.
//

import UIKit

class SimpleLoginView: DefaultView {
	var callBack: UISimpleLoginViewCallBack?
	
	var constrainView = UIView()
	var pinView = PassCodeView()
	lazy var oneButton = self.makePadButton(with: .one)
	lazy var twoButton = self.makePadButton(with: .two)
	lazy var threeButton = self.makePadButton(with: .three)
	lazy var fourButton = self.makePadButton(with: .four)
	lazy var fiveButton = self.makePadButton(with: .five)
	lazy var sixButton = self.makePadButton(with: .six)
	lazy var sevenButton = self.makePadButton(with: .seven)
	lazy var eightButton = self.makePadButton(with: .eight)
	lazy var nineButton = self.makePadButton(with: .nine)
	lazy var zeroButton = self.makePadButton(with: .zero)
	lazy var backspaceButton = self.makeAdditionalKeyboardButton(with:
																	AppImage.PinPad.backspace.rawValue)
	lazy var faceIdButton = self.makeAdditionalKeyboardButton(with: AppImage.PinPad.authImage)
	var forgetPasswordButton = UIButton()

	override init(controllerTitle: String? = nil, screenType: ScreenTypes = .other) {
		super.init(controllerTitle: controllerTitle, screenType: screenType)
		self.setupPinView()
		self.setupPadView()
	}
}

private extension SimpleLoginView {
	func setupPinView() {
		self.contentView.addSubview(constrainView)
		self.constrainView.snp.makeConstraints { make in
			make.top.trailing.equalTo(contentView)
			make.leading.equalTo(contentView).offset(AppContraints.midEdge)
			make.width.equalTo(AppContraints.PinPadLogin.passCodeWidth)
		}
		self.constrainView.addSubview(pinView)
		self.pinView.snp.makeConstraints { make in
			make.top.equalTo(self.constrainView)
			make.centerX.equalTo(self.constrainView)
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

		self.forgetPasswordButton.snp.makeConstraints { make in
			make.centerX.equalTo(self.contentView)
			make.top.equalTo(self.zeroButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.forgetPasswordButton.setTitle(AppTitle.PassCode.forgetTitle, for: .normal)
		self.forgetPasswordButton.setTitleColor(self.colors.passCodeColor.textColor, for: .normal)
		self.forgetPasswordButton.addTarget(self, action: #selector(forgetPasswordButtonTapped), for: .touchUpInside)
	}

	func setupFirstPadRow() {
		self.contentView.addSubview(self.twoButton)
		self.twoButton.snp.makeConstraints { make in
			make.top.equalTo(self.pinView.snp.bottom).offset(AppContraints.navTitle)
			make.centerX.equalTo(self.contentView)
		}
		self.twoButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.oneButton)
		self.oneButton.snp.makeConstraints { make in
			make.top.equalTo(pinView.snp.bottom).offset(AppContraints.navTitle)
			make.trailing.equalTo(twoButton.snp.leading).offset(-AppContraints.standartEdge)
		}
		self.oneButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.threeButton)
		self.threeButton.snp.makeConstraints { make in
			make.top.equalTo(pinView.snp.bottom).offset(AppContraints.navTitle)
			make.leading.equalTo(twoButton.snp.trailing).offset(AppContraints.standartEdge)
		}
		self.threeButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
	}

	func setupSecondPadRow() {
		self.contentView.addSubview(self.fourButton)
		self.fourButton.snp.makeConstraints { make in
			make.leading.equalTo(self.oneButton)
			make.top.equalTo(self.oneButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.fourButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.fiveButton)
		self.fiveButton.snp.makeConstraints { make in
			make.leading.equalTo(self.twoButton)
			make.top.equalTo(self.twoButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.fiveButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.sixButton)
		self.sixButton.snp.makeConstraints { make in
			make.leading.equalTo(self.threeButton)
			make.top.equalTo(self.threeButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.sixButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
	}

	func setupThirdPadRow() {
		self.contentView.addSubview(self.sevenButton)
		self.sevenButton.snp.makeConstraints { make in
			make.leading.equalTo(self.oneButton)
			make.top.equalTo(fourButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.sevenButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.eightButton)
		self.eightButton.snp.makeConstraints { make in
			make.leading.equalTo(self.fiveButton)
			make.top.equalTo(self.fiveButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.eightButton.addTarget(self, action: #selector(self.numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.nineButton)
		self.nineButton.snp.makeConstraints { make in
			make.leading.equalTo(self.sixButton)
			make.top.equalTo(self.sixButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.nineButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.zeroButton)
		self.zeroButton.snp.makeConstraints { make in
			make.leading.equalTo(self.eightButton)
			make.top.equalTo(self.eightButton.snp.bottom).offset(AppContraints.standartEdge)
		}
	}

	func setupFourthPadRow() {
		self.zeroButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.faceIdButton)
		self.faceIdButton.snp.makeConstraints { make in
			make.leading.equalTo(self.sevenButton)
			make.top.equalTo(self.sevenButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.faceIdButton.addTarget(self, action: #selector(faceIdButtonTapped), for: .touchUpInside)

		self.contentView.addSubview(self.backspaceButton)
		self.backspaceButton.snp.makeConstraints { make in
			make.leading.equalTo(self.nineButton)
			make.top.equalTo(self.nineButton.snp.bottom).offset(AppContraints.standartEdge)
		}
		self.backspaceButton.addTarget(self, action: #selector(backspaceButtonTapped), for: .touchUpInside)

		self.contentView.addSubview(self.forgetPasswordButton)
	}

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

	func makeAdditionalKeyboardButton(with imageName: String) -> UIButton {
		let button = UIButton()
		button.snp.makeConstraints { make in
			make.width.height.equalTo(AppContraints.PinPadLogin.padSize)
		}
		button.layer.backgroundColor = self.colors.passCodeColor.buttonBgColor

		let imageView = UIImageView()
		let image = UIImage(systemName: imageName)
		imageView.image = image
		imageView.tintColor = self.colors.passCodeColor.buttonNumberColor
		button.addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.leading.top.equalTo(button).offset(AppContraints.standartEdge)
			make.trailing.bottom.equalTo(button).offset(-AppContraints.standartEdge)
		}
		return button
	}

	func buttonsAnimation(for button: UIButton) {
		DispatchQueue.main.async {
			UIButton.animate(withDuration: 0.01,
							 delay: 0,
							 usingSpringWithDamping: 1,
							 initialSpringVelocity: 1,
							 options: .curveEaseInOut) { [ weak self ] in
				button.layer.backgroundColor = self?.colors.passCodeColor.buttonTappedBgColor
			}
			UIButton.animate(withDuration: 0.01,
							 delay: 0.01,
							 usingSpringWithDamping: 1,
							 initialSpringVelocity: 1,
							 options: .curveEaseInOut) { [ weak self ] in
				button.layer.backgroundColor = self?.colors.passCodeColor.buttonBgColor
			}
		}
	}
}

@objc
private extension SimpleLoginView {
	func numberButtonTapped(sender: UIButton) {
		self.buttonsAnimation(for: sender)
		guard sender.tag != -1 else { return }
		self.pinView.insertText("\(sender.tag)")
		if self.pinView.endEditing == true {
			print("send to ")
			self.callBack?.pinEndEditing(pin: self.pinView.code)
		}
	}

	func faceIdButtonTapped(sender: UIButton) {
		print("touchId touched")
		self.callBack?.touchIdButtonTapped()
	}

	func backspaceButtonTapped(sender: UIButton) {
		self.pinView.deleteBackward()
	}

	func forgetPasswordButtonTapped(sender: UIButton) {
		print("send it to presenter0 self.presenter.forgetButtonTapped()")
		self.callBack?.forgetButtonTapped()
	}
}
