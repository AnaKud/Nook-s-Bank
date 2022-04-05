// FullLoginView.swift
// Created by Anastasiya Kudasheva on 30.08.2021.

import UIKit

class FullLoginView: UIView {
	private var callBack: UIFullLoginViewCallBack?
	private let colors = ColorSet(for: .loginScreen(.full))

	private let welcomeLabel = UILabel()
	private let appNameLabel = UILabel()
	private lazy var emailTextField = CustomTextField(
		settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Login.cornerRadiusTF,
		placeholder: AppTitle.Login.emailTF,
		image: AppImage.Login.iconForEmailTF.image
	))
	private lazy var passwordNameTextField = CustomTextField(
		settings: CustomTextField.Settings(
		color: self.colors,
		cornerRadius: AppContraints.Login.cornerRadiusTF,
		placeholder: AppTitle.Login.passwordTF,
		image: AppImage.Login.iconForPasswordTF.image,
		isSecureTextEntry: true
	))
	private lazy var loginButton = OvalButton(
		withTitle: AppTitle.Login.loginButton,
		width: AppContraints.Login.widthLoginButton,
		height: AppContraints.Login.heightButtons,
		color: self.colors
	)
	private lazy var registerButton = OvalButton(
		withTitle: AppTitle.Login.registerButton,
		width: AppContraints.Login.widthButton,
		height: AppContraints.Login.heightButtons,
		color: self.colors
	)
	private lazy var freeEnterButton = OvalButton(
		withTitle: AppTitle.Login.freeButton,
		width: AppContraints.Login.widthButton,
		height: AppContraints.Login.heightButtons,
		color: self.colors
	)
	private lazy var forgetPasswordButton = OvalButton(
		withTitle: AppTitle.PassCode.forgetTitle,
		width: AppContraints.Login.widthForgetButton,
		height: AppContraints.Login.heightButtons,
		color: self.colors
	)

	init() {
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupCallBack(_ callBack: UIFullLoginViewCallBack?) {
		self.callBack = callBack
	}
}

// MARK: - General Views
private extension FullLoginView {
	func loadUI() {
		self.textSettings()
		self.setupTitles()
		self.setupTextFields()
		self.setupButtons()
		self.setupForgetPasswordButton()
		self.addActionForButtons()
	}

	func setupTitles() {
		self.backgroundColor = self.colors.mainViewColor.backgroundColor

		self.addSubview(self.welcomeLabel)
		self.welcomeLabel.snp.makeConstraints { make in
			make.top.equalTo(self).offset(AppContraints.Login.loginVerticalEdge)
			make.leading.trailing.equalTo(self)
		}
		self.addSubview(self.appNameLabel)
		self.appNameLabel.snp.makeConstraints { make in
			make.top.equalTo(self.welcomeLabel.snp.bottom).offset(AppContraints.minEdge)
			make.leading.trailing.equalTo(self)
		}
	}

	func setupTextFields() {
		self.addSubview(self.emailTextField)
		self.emailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.appNameLabel.snp.bottom).offset(AppContraints.Login.loginMinVerticalEdge)
			make.leading.equalTo(self).offset(AppContraints.Login.loginHorizontelEdge)
			make.trailing.equalTo(self).offset(-AppContraints.Login.loginHorizontelEdge)
			make.height.equalTo(AppContraints.Login.heightTF)
		}
		self.addSubview(self.passwordNameTextField)
		self.passwordNameTextField.snp.makeConstraints { make in
			make.top.equalTo(self.emailTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self).offset(AppContraints.Login.loginHorizontelEdge)
			make.trailing.equalTo(self).offset(-AppContraints.Login.loginHorizontelEdge)
			make.height.equalTo(AppContraints.Login.heightTF)
		}
	}

	func setupButtons() {
		self.addSubview(self.loginButton)
		self.loginButton.snp.makeConstraints { make in
			make.top.equalTo(self.passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
			make.height.equalTo(AppContraints.Login.heightButtons)
			make.width.equalTo(AppContraints.Login.widthLoginButton)
			make.centerX.equalTo(self)
		}
		self.addSubview(self.registerButton)
		self.registerButton.snp.makeConstraints { make in
			make.top.equalTo(passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
			make.trailing.equalTo(loginButton.snp.leading).offset(-AppContraints.minEdge)
		}
		self.addSubview(self.freeEnterButton)
		self.freeEnterButton.snp.makeConstraints { make in
			make.top.equalTo(self.passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
			make.leading.equalTo(self.loginButton.snp.trailing).offset(AppContraints.minEdge)
		}
	}

	func setupForgetPasswordButton() {
		self.addSubview(self.forgetPasswordButton)
		self.forgetPasswordButton.snp.makeConstraints { make in
			make.centerX.equalTo(self)
			make.top.equalTo(self.loginButton.snp.bottom).offset(AppContraints.midEdge)
		}
	}
}

// MARK: - Subviews settings
private extension FullLoginView {
	func textSettings() {
		self.welcomeLabel.textAlignment = .center
		self.welcomeLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
		self.welcomeLabel.font = ACFont.welcomeFont.font
		self.welcomeLabel.text = AppTitle.welcome
		self.appNameLabel.textAlignment = .center
		self.appNameLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
		self.appNameLabel.font = ACFont.appNameFont.font
		self.appNameLabel.text = AppTitle.nookBank
	}

	func addActionForButtons() {
		self.passwordNameTextField.addTarget(self,
											 action: #selector(self.passwordTextfieldEndEditing),
											 for: .editingDidEndOnExit)
		self.registerButton.addTarget(self, action: #selector(self.registerButtonTapped), for: .touchUpInside)
		self.loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
		self.freeEnterButton.addTarget(self, action: #selector(self.continueButtonTapped), for: .touchUpInside)
		self.forgetPasswordButton.addTarget(self, action: #selector(self.forgetPasswordButtonTapped), for: .touchUpInside)
	}
}

// MARK: - Objc actions
@objc
private extension FullLoginView {
	func registerButtonTapped(sender: UIButton) {
		self.callBack?.registerButtonTapped(withUserName: "",
											email: self.emailTextField.text,
											password: self.passwordNameTextField.text)
	}

	func loginButtonTapped(sender: UIButton) {
		self.callBack?.loginButtonTapped(email: self.emailTextField.text,
										 password: self.passwordNameTextField.text)
	}

	func continueButtonTapped(sender: UIButton) {
		self.callBack?.continueButtonTapped()
	}

	func passwordTextfieldEndEditing() {
		self.passwordNameTextField.resignFirstResponder()
		self.callBack?.loginButtonTapped(email: self.emailTextField.text,
										 password: self.passwordNameTextField.text)
	}

	func forgetPasswordButtonTapped(sender: UIButton) {
		self.callBack?.forgetPasswordButtonTapped(email: self.emailTextField.text)
	}
}
