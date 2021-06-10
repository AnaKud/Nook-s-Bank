//
//  LoginViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import UIKit
import SnapKit

protocol ILoginViewController {
    func refreshView()
}

class LoginViewController: CustomViewController {
    var presenter: ILoginPresenter
    let welcomeLabel = UILabel()
    let appNameLabel = UILabel()
    let userNameTextField = makeTextField(withPlacehoder: AppTitle.Login.userNameTF, withImageName: AppImage.Login.iconForUserTF.rawValue)
    let passwordNameTextField = makeTextField(withPlacehoder: AppTitle.Login.passwordTF, withImageName: AppImage.Login.iconForPasswordTF.rawValue)
    let loginButton = makeOvalButtonWithCircle(withTitle: AppTitle.Login.loginButton, buttonWidth: AppContraints.Login.widthLoginButton, buttonHeight: AppContraints.Login.heightButtons)
    let registerButton = makeOvalButtonWithCircle(withTitle: AppTitle.Login.registerButton, buttonWidth: AppContraints.Login.widthButton, buttonHeight: AppContraints.Login.heightButtons)
    let freeEnterButton = makeOvalButtonWithCircle(withTitle: AppTitle.Login.freeButton, buttonWidth: AppContraints.Login.widthButton, buttonHeight: AppContraints.Login.heightButtons)
    
    init(presenter: ILoginPresenter) {
        
        self.presenter = presenter
        super.init(userStatus: .loginScreen, title: AppTitle.nookBank)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(view: self)
        
        
        self.setupInterface()
        self.setupLayout()
        
    }
    
    private func setupLayout() {
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
        
        view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(AppContraints.Login.loginVerticalEdge)
            make.leading.equalTo(view).offset(AppContraints.Login.loginHorizontelEdge)
            make.trailing.equalTo(view).offset(-AppContraints.Login.loginHorizontelEdge)
        }
        
        view.addSubview(passwordNameTextField)
        passwordNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(AppContraints.midEdge)
            make.leading.equalTo(view).offset(AppContraints.Login.loginHorizontelEdge)
            make.trailing.equalTo(view).offset(-AppContraints.Login.loginHorizontelEdge)
        }
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
    }
    
    
    
}

extension LoginViewController: ILoginViewController {
    func refreshView() {
        
    }
}
