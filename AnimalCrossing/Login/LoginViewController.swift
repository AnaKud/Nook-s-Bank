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
    let loginButton = makeOvalButtonWithCircle(withTitle: AppTitle.Login.loginButton, buttonWidth: AppContraints.Login.widthButton, buttonHeight: AppContraints.Login.heightButtons)
    let freeEnterButton = makeOvalButtonWithCircle(withTitle: AppTitle.Login.freeButton, buttonWidth: AppContraints.Login.widthButton, buttonHeight: AppContraints.Login.heightButtons)
    
    init(presenter: ILoginPresenter) {
        
        self.presenter = presenter
        super.init(userStatus: .loggined, title: AppTitle.nookBank)
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
            make.top.equalTo(titleLabel.snp.bottom).offset(AppContraints.Login.loginVerticalEdge)
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
            make.top.equalTo(userNameTextField.snp.bottom).offset(AppContraints.standartEdge)
            make.leading.equalTo(view).offset(AppContraints.Login.loginHorizontelEdge)
            make.trailing.equalTo(view).offset(-AppContraints.Login.loginHorizontelEdge)
        }
        view.addSubview(freeEnterButton)
        freeEnterButton.snp.makeConstraints { make in
            make.top.equalTo(passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
            make.leading.equalTo(view).offset(AppContraints.Login.loginHorizontelEdge)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordNameTextField.snp.bottom).offset(AppContraints.standartEdge)
            
            make.trailing.equalTo(view).offset(-AppContraints.Login.loginHorizontelEdge)
        }
    }
    
    private func setupInterface() {
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        welcomeLabel.font = UIFont(name: AppFont.fink.rawValue, size: 26)
        welcomeLabel.text = AppTitle.welcome
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        appNameLabel.font = UIFont(name: AppFont.fink.rawValue, size: 30)
        appNameLabel.text = AppTitle.nookBank
    }
    
    
    
}

extension LoginViewController: ILoginViewController {
    func refreshView() {
        
    }
}
