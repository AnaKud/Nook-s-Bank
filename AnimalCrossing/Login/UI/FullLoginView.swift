//
//  FullLoginView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 30.08.2021.
//

import UIKit

class FullLoginView: DefaultView {
	var callBack: UIFullLoginViewCallBack?

	let welcomeLabel = UILabel()
	let appNameLabel = UILabel()
	var emailTextField = UITextField()
	var passwordNameTextField = UITextField()
	var loginButton = UIButton()
	var registerButton = UIButton()
	var freeEnterButton = UIButton()
	let warningLabel = UILabel()

	override init(controllerTitle: String? = nil, screenType: ScreenTypes = .other) {
		super.init(controllerTitle: controllerTitle, screenType: screenType)
		self.loadUI()
	}
	
	private func loadUI() {
		self.controllerTitle = ""
		self.textSettings()
		self.setupTitles()
		self.setupTextFields()
		self.setupButtons()
		self.addActionForButton()
	}

	private func setupTitles() {
		self.mainView.addSubview(self.welcomeLabel)
		self.welcomeLabel.snp.makeConstraints { make in
			make.top.equalTo(self.mainView).offset(AppContraints.Login.loginVerticalEdge)
			make.leading.trailing.equalTo(self.mainView)
		}
		self.mainView.addSubview(self.appNameLabel)
		self.appNameLabel.snp.makeConstraints { make in
			make.top.equalTo(self.welcomeLabel.snp.bottom).offset(AppContraints.minEdge)
			make.leading.trailing.equalTo(self.mainView)
		}
	}
	
	private func setupTextFields() {
		self.emailTextField = self.customView.makeTextField(withPlacehoder: AppTitle.Login.emailTF,
										  height: AppContraints.Login.heightTF,
										  cornerRadius: AppContraints.Login.cornerRadiusTF,
										  withImageName: AppImage.Login.iconForEmailTF.rawValue,
										  isSecureTextEntry: false)
		self.mainView.addSubview(self.emailTextField)
		self.emailTextField.snp.makeConstraints { make in
			make.top.equalTo(self.appNameLabel.snp.bottom).offset(AppContraints.Login.loginMinVerticalEdge)
			make.leading.equalTo(self.mainView).offset(AppContraints.Login.loginHorizontelEdge)
			make.trailing.equalTo(self.mainView).offset(-AppContraints.Login.loginHorizontelEdge)
		}
		self.passwordNameTextField = self.customView.makeTextField(withPlacehoder: AppTitle.Login.passwordTF,
										  height: AppContraints.Login.heightTF,
										  cornerRadius: AppContraints.Login.cornerRadiusTF,
										  withImageName: AppImage.Login.iconForPasswordTF.rawValue,
										  isSecureTextEntry: true)
		self.mainView.addSubview(self.passwordNameTextField)
		self.passwordNameTextField.snp.makeConstraints { make in
			make.top.equalTo(self.emailTextField.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.mainView).offset(AppContraints.Login.loginHorizontelEdge)
			make.trailing.equalTo(self.mainView).offset(-AppContraints.Login.loginHorizontelEdge)
		}
	}
	
	private func setupButtons() {
		self.loginButton = self.customView.makeOvalButtonWithCircle(withTitle: AppTitle.Login.loginButton,
												  buttonWidth: AppContraints.Login.widthLoginButton,
												  buttonHeight: AppContraints.Login.heightButtons)
		self.mainView.addSubview(self.loginButton)
		self.loginButton.snp.makeConstraints { make in
			make.top.equalTo(self.passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
			make.centerX.equalTo(self.mainView)
		}
		self.registerButton = self.customView.makeOvalButtonWithCircle(withTitle: AppTitle.Login.registerButton,
												  buttonWidth: AppContraints.Login.widthButton,
												  buttonHeight: AppContraints.Login.heightButtons)
		self.mainView.addSubview(self.registerButton)
		self.registerButton.snp.makeConstraints { make in
			make.top.equalTo(passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
			make.trailing.equalTo(loginButton.snp.leading).offset(-AppContraints.minEdge)
		}
		self.freeEnterButton = self.customView.makeOvalButtonWithCircle(withTitle: AppTitle.Login.freeButton,
												  buttonWidth: AppContraints.Login.widthButton,
												  buttonHeight: AppContraints.Login.heightButtons)
		self.mainView.addSubview(self.freeEnterButton)
		self.freeEnterButton.snp.makeConstraints { make in
			make.top.equalTo(self.passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
			make.leading.equalTo(self.loginButton.snp.trailing).offset(AppContraints.minEdge)
		}
		self.mainView.addSubview(self.warningLabel)
		self.warningLabel.snp.makeConstraints { make in
			make.top.equalTo(self.loginButton.snp.bottom).offset(AppContraints.standartEdge)
			make.leading.equalTo(self.mainView).offset(AppContraints.Login.loginHorizontelEdge)
			make.trailing.equalTo(self.mainView).offset(-AppContraints.Login.loginHorizontelEdge)
			make.height.equalTo(21)
		}
		
		
		
		
		
		
		// secretInfo DELETE THIS
			emailTextField.text = "TestNB@test.ru"
			passwordNameTextField.text = "123456"
	}

	private func textSettings() {
		self.welcomeLabel.textAlignment = .center
		self.welcomeLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
		self.welcomeLabel.font = UIFont(name: AppFont.fink.rawValue, size: AppContraints.FontsSize.welcomeFont)
		self.welcomeLabel.text = AppTitle.welcome
		self.appNameLabel.textAlignment = .center
		self.appNameLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
		self.appNameLabel.font = UIFont(name: AppFont.fink.rawValue, size: AppContraints.FontsSize.appNameFont)
		self.appNameLabel.text = AppTitle.nookBank
		self.warningLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
		self.warningLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: AppContraints.FontsSize.defaultFont)
		self.warningLabel.numberOfLines = 0
		self.warningLabel.textAlignment = .center
	}

	private func addActionForButton() {
		self.passwordNameTextField.addTarget(self, action: #selector(passwordTextfieldEndEditing), for: .editingDidEndOnExit)
		self.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
		self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
		self.freeEnterButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
	}
}

private extension FullLoginView {
	func showWarningLabel(withWarningText warningText: String) {
		warningLabel.text = warningText
		UIView.animate(withDuration: 5,
					   delay: 0,
					   usingSpringWithDamping: 1,
					   initialSpringVelocity: 1,
					   options: .curveEaseInOut,
					   animations: { [ weak self ] in
						self?.warningLabel.alpha = 1
					   }) { [ weak self ] _ in self?.warningLabel.alpha = 0 }
	}
}

@objc extension FullLoginView {
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
}
