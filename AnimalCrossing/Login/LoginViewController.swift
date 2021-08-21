//
//  LoginViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import SnapKit
import UIKit

protocol ILoginViewController {
    func setupFullLoginView()
    func setupSimpleLoginView()
    func showUserNameAlert(withEmail email: String, withPassword password: String)
    func showWarningLabel(withWarningText warningText: String)
    func showErrorAlert(withMessage message: FailureCases)
}

class LoginViewController: CustomViewController {
    var presenter: ILoginPresenter
    let welcomeLabel = UILabel()
    let appNameLabel = UILabel()
    var emailTextField = UITextField()
    var passwordNameTextField = UITextField()
    var loginButton = UIButton()
    var registerButton = UIButton()
    var freeEnterButton = UIButton()
    let warningLabel = UILabel()

    var constrainView = UIView()
    var pinView = PassCodeView()
    var oneButton = UIButton()
    var twoButton = UIButton()
    var threeButton = UIButton()
    var fourButton = UIButton()
    var fiveButton = UIButton()
    var sixButton = UIButton()
    var sevenButton = UIButton()
    var eightButton = UIButton()
    var nineButton = UIButton()
    var zeroButton = UIButton()
    var backspaceButton = UIButton()
    var faceIdButton = UIButton()
    var forgetPasswordButton = UIButton()

    init(presenter: ILoginPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
        self.screenType = .loginScreen
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(view: self)
    }

    func setupFullLoginView() {
        DispatchQueue.main.async {
            self.view.backgroundColor = self.colors?.mainViewColor.backgroundColor
            self.controllerTitle = ""
            self.setupInterface()
            self.setupLayout()
            self.addActionForButton()
        }
    }

    func setupSimpleLoginView() {
        DispatchQueue.main.async {
            self.view.backgroundColor = self.colors?.mainViewColor.backgroundColor
            self.titleLabel.text = AppTitle.nookBank
            self.setupPinView()
            self.setupPadView()
        }
    }

    private func setupLayout() {
        emailTextField = self.customView?.makeTextField(withPlacehoder: AppTitle.Login.emailTF,
														height: AppContraints.Login.heightTF,
														cornerRadius: AppContraints.Login.cornerRadiusTF,
														withImageName: AppImage.Login.iconForEmailTF.rawValue,
														isSecureTextEntry: false) ?? UITextField()
        passwordNameTextField = self.customView?.makeTextField(withPlacehoder: AppTitle.Login.passwordTF,
															   height: AppContraints.Login.heightTF,
															   cornerRadius: AppContraints.Login.cornerRadiusTF,
															   withImageName: AppImage.Login.iconForPasswordTF.rawValue,
															   isSecureTextEntry: true) ?? UITextField()
         loginButton = self.customView?.makeOvalButtonWithCircle(withTitle: AppTitle.Login.loginButton,
																 buttonWidth: AppContraints.Login.widthLoginButton,
																 buttonHeight: AppContraints.Login.heightButtons) ?? UIButton()
         registerButton = self.customView?.makeOvalButtonWithCircle(withTitle: AppTitle.Login.registerButton,
																	buttonWidth: AppContraints.Login.widthButton,
																	buttonHeight: AppContraints.Login.heightButtons) ?? UIButton()
         freeEnterButton = self.customView?.makeOvalButtonWithCircle(withTitle: AppTitle.Login.freeButton,
																	 buttonWidth: AppContraints.Login.widthButton,
																	 buttonHeight: AppContraints.Login.heightButtons) ?? UIButton()
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(AppContraints.Login.loginVerticalEdge)
            make.leading.trailing.equalTo(view)
        }
        view.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(AppContraints.minEdge)
            make.leading.trailing.equalTo(view)
        }
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(AppContraints.Login.loginMinVerticalEdge)
            make.leading.equalTo(view).offset(AppContraints.Login.loginHorizontelEdge)
            make.trailing.equalTo(view).offset(-AppContraints.Login.loginHorizontelEdge)
        }
        view.addSubview(passwordNameTextField)
        passwordNameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(AppContraints.midEdge)
            make.leading.equalTo(view).offset(AppContraints.Login.loginHorizontelEdge)
            make.trailing.equalTo(view).offset(-AppContraints.Login.loginHorizontelEdge)
        }
        passwordNameTextField.addTarget(self, action: #selector(passwordTextfieldEndEditing), for: .editingDidEndOnExit)

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
            make.centerX.equalTo(view)
        }
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
            make.trailing.equalTo(loginButton.snp.leading).offset(-AppContraints.minEdge)
        }
        view.addSubview(freeEnterButton)
        freeEnterButton.snp.makeConstraints { make in
            make.top.equalTo(passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
            make.leading.equalTo(loginButton.snp.trailing).offset(AppContraints.minEdge)
        }
        view.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(AppContraints.standartEdge)
            make.leading.equalTo(view).offset(AppContraints.Login.loginHorizontelEdge)
            make.trailing.equalTo(view).offset(-AppContraints.Login.loginHorizontelEdge)
        }
		// secretInfo DELETE THIS
			emailTextField.text = "TestNB@test.ru"
			passwordNameTextField.text = "123456"
    }

    private func setupInterface() {
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        welcomeLabel.font = UIFont(name: AppFont.fink.rawValue, size: AppContraints.FontsSize.welcomeFont)
        welcomeLabel.text = AppTitle.welcome
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        appNameLabel.font = UIFont(name: AppFont.fink.rawValue, size: AppContraints.FontsSize.appNameFont)
        appNameLabel.text = AppTitle.nookBank
        warningLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        warningLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: AppContraints.FontsSize.defaultFont)
        warningLabel.numberOfLines = 0
        warningLabel.textAlignment = .center
    }

    private func addActionForButton() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        freeEnterButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    private func setupPinView() {
        contentView.addSubview(constrainView)
        constrainView.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView)
            make.leading.equalTo(contentView).offset(AppContraints.midEdge)
            make.width.equalTo(AppContraints.PinPadLogin.passCodeWidth)
        }
        constrainView.addSubview(pinView)
        pinView.snp.makeConstraints { make in
            make.top.equalTo(constrainView)
            make.centerX.equalTo(constrainView)
            make.width.equalTo(AppContraints.PinPadLogin.passCodeWidth)
            make.height.equalTo(AppContraints.PinPadLogin.pinSize)
        }
        pinView.becomeFirstResponder()
    }
    private func setupPadView() {
        twoButton = makePadButton(with: .two)
        contentView.addSubview(twoButton)
        twoButton.snp.makeConstraints { make in
            make.top.equalTo(pinView.snp.bottom).offset(AppContraints.navTitle)
            make.centerX.equalTo(contentView)
        }
		twoButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        oneButton = makePadButton(with: .one)
        contentView.addSubview(oneButton)
        oneButton.snp.makeConstraints { make in
            make.top.equalTo(pinView.snp.bottom).offset(AppContraints.navTitle)
            make.trailing.equalTo(twoButton.snp.leading).offset(-AppContraints.standartEdge)
        }
        oneButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        threeButton = makePadButton(with: .three)
        contentView.addSubview(threeButton)
        threeButton.snp.makeConstraints { make in
            make.top.equalTo(pinView.snp.bottom).offset(AppContraints.navTitle)
            make.leading.equalTo(twoButton.snp.trailing).offset(AppContraints.standartEdge)
        }
        threeButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        fourButton = makePadButton(with: .four)
        contentView.addSubview(fourButton)
        fourButton.snp.makeConstraints { make in
            make.leading.equalTo(oneButton)
            make.top.equalTo(oneButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        fourButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        fiveButton = makePadButton(with: .five)
        contentView.addSubview(fiveButton)
        fiveButton.snp.makeConstraints { make in
            make.leading.equalTo(twoButton)
            make.top.equalTo(twoButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        fiveButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        sixButton = makePadButton(with: .six)
        contentView.addSubview(sixButton)
        sixButton.snp.makeConstraints { make in
            make.leading.equalTo(threeButton)
            make.top.equalTo(threeButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        sixButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        sevenButton = makePadButton(with: .seven)
        contentView.addSubview(sevenButton)
        sevenButton.snp.makeConstraints { make in
            make.leading.equalTo(oneButton)
            make.top.equalTo(fourButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        sevenButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        eightButton = makePadButton(with: .eight)
        contentView.addSubview(eightButton)
        eightButton.snp.makeConstraints { make in
            make.leading.equalTo(fiveButton)
            make.top.equalTo(fiveButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        eightButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        nineButton = makePadButton(with: .nine)
        contentView.addSubview(nineButton)
        nineButton.snp.makeConstraints { make in
            make.leading.equalTo(sixButton)
            make.top.equalTo(sixButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        nineButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        zeroButton = makePadButton(with: .zero)
        contentView.addSubview(zeroButton)
        zeroButton.snp.makeConstraints { make in
            make.leading.equalTo(eightButton)
            make.top.equalTo(eightButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        zeroButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)
        faceIdButton = makeAdditionalKeyboardButton(with: .faceId)
        contentView.addSubview(faceIdButton)
        faceIdButton.snp.makeConstraints { make in
            make.leading.equalTo(sevenButton)
            make.top.equalTo(sevenButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        faceIdButton.addTarget(self, action: #selector(numberButtonTapped), for: .touchUpInside)

        backspaceButton = makeAdditionalKeyboardButton(with: .backspace)
        contentView.addSubview(backspaceButton)
        backspaceButton.snp.makeConstraints { make in
            make.leading.equalTo(nineButton)
            make.top.equalTo(nineButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        backspaceButton.addAction(UIAction(handler: { _ in
            self.pinView.deleteBackward()
        }), for: .touchUpInside)

        bottomImageView.isHidden = true
        view.addSubview(forgetPasswordButton)

        forgetPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)

           make.top.equalTo(zeroButton.snp.bottom).offset(AppContraints.standartEdge)
        }
        forgetPasswordButton.addAction(UIAction(handler: { _ in
            self.presenter.forgetButtonTapped()
        }), for: .touchUpInside)
        forgetPasswordButton.setTitle(AppTitle.PassCode.forgetTitle, for: .normal)
        forgetPasswordButton.setTitleColor(colors?.passCodeColor.textColor, for: .normal)
    }
}

extension LoginViewController: ILoginViewController {
    func showWarningLabel(withWarningText warningText: String) {
        warningLabel.text = warningText
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warningLabel.alpha = 1
        }) { [weak self] _ in
            self?.warningLabel.alpha = 0
        }
    }

    func showUserNameAlert(withEmail email: String, withPassword password: String) {
        let alert = CustomAlertController(title: AppTitle.Login.hello, message: AppTitle.Login.nameMessage, preferredStyle: .alert)
        alert.addTextField { nameTextField in
            nameTextField.addAction(UIAction(handler: { _ in
                if alert.textFields?[0].text?.isEmpty == false {
                    alert.actions[0].isEnabled = true
                }
				if nameTextField.text?.isEmpty ?? true {
                    alert.actions[0].isEnabled = false
                }
            }), for: .editingChanged)
        }
        let saveAction = UIAlertAction(title: AppTitle.save, style: .default) { _ in
            guard let nameTextField = alert.textFields?[0], let nameText = nameTextField.text
            else { return }
            self.presenter.registerUser(withUserName: nameText, withEmail: email, withPassword: password)
        }
        let cancelAction = UIAlertAction(title: AppTitle.cancel, style: .cancel)
        saveAction.isEnabled = false
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}

extension LoginViewController {
    private func makePadButton(with title: PadKeyBoard) -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.width.height.equalTo(AppContraints.PinPadLogin.padSize)
        }
        button.backgroundColor = colors?.passCodeColor.buttonBgColor
        button.layer.cornerRadius = AppContraints.PinPadLogin.padCorner
        button.layer.borderWidth = AppContraints.PinPadLogin.padBorder
        button.layer.borderColor = colors?.passCodeColor.buttonBorderColor
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
        label.font = UIFont(name: AppFont.maruBold.rawValue, size: AppContraints.FontsSize.padFont)
        label.textColor = colors?.passCodeColor.buttonNumberColor

        return button
    }

    private func makeAdditionalKeyboardButton(with imageName: AppImage.PinPad) -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.width.height.equalTo(AppContraints.PinPadLogin.padSize)
        }
        button.backgroundColor = colors?.passCodeColor.buttonBgColor

        let imageView = UIImageView()
        let image = UIImage(systemName: imageName.rawValue)
        imageView.image = image
        imageView.tintColor = colors?.passCodeColor.buttonNumberColor
        button.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.top.equalTo(button).offset(AppContraints.standartEdge)
            make.trailing.bottom.equalTo(button).offset(-AppContraints.standartEdge)
        }
        return button
    }
}

@objc extension LoginViewController {
	func registerButtonTapped(sender: UIButton) {
		self.presenter.registerButtonTapped(email: emailTextField.text, password: passwordNameTextField.text)
	}

	func loginButtonTapped(sender: UIButton) {
		self.presenter.loginButtonTapped(email: emailTextField.text, password: passwordNameTextField.text)
	}

	func continueButtonTapped(sender: UIButton) {
		self.presenter.openWithoutLogin()
	}

	func passwordTextfieldEndEditing() {
		self.passwordNameTextField.resignFirstResponder()
		self.presenter.loginButtonTapped(email: emailTextField.text, password: passwordNameTextField.text)
	}
	func numberButtonTapped(sender: UIButton) {
		guard sender.tag != -1 else { return }
		self.pinView.insertText("\(sender.tag)")
	}
}

// TO-DO GenericKeychain
