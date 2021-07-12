//
//  LoginViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import UIKit
import SnapKit

protocol ILoginViewController {
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
    
    init(presenter: ILoginPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        self.screenType = .loginScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controllerTitle = ""
        self.presenter.viewDidLoad(view: self)
        self.setupInterface()
        self.setupLayout()
        self.addActionForButton()
    }
    
    @objc func registerButtonPressed(sender: UIButton) {
        self.presenter.registerButtonTapped(email: emailTextField.text, password: passwordNameTextField.text)
    }
    
    @objc func loginButtonPressed(sender: UIButton) {
        self.presenter.loginButtonTapped(email: emailTextField.text, password: passwordNameTextField.text)
    }
    
    @objc func continueButtonPressed(sender: UIButton) {
        self.presenter.openWithoutLogin()
    }
    
    @objc func passwordTextfieldEndEditing() {
        self.passwordNameTextField.resignFirstResponder()
        self.presenter.loginButtonTapped(email: emailTextField.text, password: passwordNameTextField.text)
    }
    
    private func setupLayout() {
        emailTextField = self.customView?.makeTextField(withPlacehoder: AppTitle.Login.emailTF, height: AppContraints.Login.heightTF, cornerRadius: AppContraints.Login.cornerRadiusTF, withImageName: AppImage.Login.iconForEmailTF.rawValue, isSecureTextEntry: false) ?? UITextField()
        passwordNameTextField = self.customView?.makeTextField(withPlacehoder: AppTitle.Login.passwordTF, height: AppContraints.Login.heightTF, cornerRadius: AppContraints.Login.cornerRadiusTF, withImageName: AppImage.Login.iconForPasswordTF.rawValue, isSecureTextEntry: true) ?? UITextField()
         loginButton = self.customView?.makeOvalButtonWithCircle(withTitle: AppTitle.Login.loginButton, buttonWidth: AppContraints.Login.widthLoginButton, buttonHeight: AppContraints.Login.heightButtons) ?? UIButton()
         registerButton = self.customView?.makeOvalButtonWithCircle(withTitle: AppTitle.Login.registerButton, buttonWidth: AppContraints.Login.widthButton, buttonHeight: AppContraints.Login.heightButtons) ?? UIButton()
         freeEnterButton = self.customView?.makeOvalButtonWithCircle(withTitle: AppTitle.Login.freeButton, buttonWidth: AppContraints.Login.widthButton, buttonHeight: AppContraints.Login.heightButtons) ?? UIButton()
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
    }
    
    private func setupInterface() {
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        welcomeLabel.font = UIFont(name: AppFont.fink.rawValue, size: 36)
        welcomeLabel.text = AppTitle.welcome
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        appNameLabel.font = UIFont(name: AppFont.fink.rawValue, size: 40)
        appNameLabel.text = AppTitle.nookBank
        warningLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        warningLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 20)
        warningLabel.numberOfLines = 0
        warningLabel.textAlignment = .center
    }
    
    private func addActionForButton() {
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        freeEnterButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }
}

extension LoginViewController: ILoginViewController {
    func showWarningLabel(withWarningText warningText: String) {
        warningLabel.text = warningText
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warningLabel.alpha = 1
        }) { [weak self] complete in
            self?.warningLabel.alpha = 0
        }
    }
    
    func showUserNameAlert(withEmail email: String, withPassword password: String) {
        let alert = CustomAlertController(title: AppTitle.Login.hello, message: AppTitle.Login.nameMessage, preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.addAction(UIAction(handler: { _ in
                let count: Int = nameTextField.text?.count ?? 0
                if alert.textFields?[0].text?.count != 0  {
                    alert.actions[0].isEnabled = true
                }
                if count == 0 {
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

// TO-DO GenericKeychain
