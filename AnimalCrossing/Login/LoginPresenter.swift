//
//  LoginPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation

protocol ILoginPresenter {
    var userStatus: UserStatus { get set }
    var titleForViewContoller: String { get set }
    func viewDidLoad(view: LoginViewController)
    func openWithoutLogin()
    func openWithLogin()
    func loginButtonTapped(email: String?, password: String?)
    func openForRegister()
    func registerButtonTapped(email: String?, password: String?)
    func showWarningLabel(withWarningText warningText: String)
    func registerUser(withUserName name: String, withEmail email: String, withPassword password: String)
    func presentError(error: FailureCases)
}

class LoginPresenter {
    var userStatus: UserStatus = .loginScreen
    var titleForViewContoller: String = ""
    var fireBaseManager: ILoginFireBaseManager
    var router: ILoginRouter
    
    var view: ILoginViewController?
    
    init(fireBaseManager: ILoginFireBaseManager, router: ILoginRouter) {
        self.fireBaseManager = fireBaseManager
        self.router = router
    }
}

extension LoginPresenter: ILoginPresenter {
    func viewDidLoad(view: LoginViewController) {
        self.view = view
    }
    
    func openWithoutLogin() {
        self.userStatus = .unloggined
        self.titleForViewContoller = AppTitle.nookBank
        self.router.goToNextWithoutLogin(withUserStatus: userStatus, withTitle: titleForViewContoller)
    }
    
    func loginButtonTapped(email: String?, password: String?) {
        self.checkEmail(email: email)
        guard let email = email, let password = password, password != "" else {
            self.showWarningLabel(withWarningText: LoginWarnings.incorrectInfo.rawValue)
            return
        }
        self.fireBaseManager.login(withEmail: email, withPassword: password)
    }
    
    func openWithLogin() {
        self.userStatus = .loggined
        self.titleForViewContoller = AppTitle.nookBank
        self.router.goToNextWithLogin(withUserStatus: userStatus, withTitle: titleForViewContoller )
    }
    
    func registerButtonTapped(email: String?, password: String?) {
        self.checkEmail(email: email)
        guard let email = email, let password = password, password != "" else {
            self.showWarningLabel(withWarningText: LoginWarnings.incorrectEmail.rawValue)
            return
        }
       // self.registerUser(withUserName: String, withEmail: email, withPassword: password)
        self.view?.showUserNameAlert(withEmail: email, withPassword: password)
    }
    func registerUser(withUserName name: String, withEmail email: String, withPassword password: String) {
        self.fireBaseManager.register(withUserName: name, withEmail: email, withPassword: password)
    }
    
    func openForRegister() {
        self.showWarningLabel(withWarningText: LoginWarnings.sucssessRegister.rawValue)
    }
    
    func showWarningLabel(withWarningText warningText: String) {
        self.view?.showWarningLabel(withWarningText: warningText)
    }
    
    private func checkEmail(email: String?) {
        guard let email = email,
              email != "",
              email.contains("@"),
              email.contains(".")
        else {
            self.showWarningLabel(withWarningText: LoginWarnings.incorrectInfo.rawValue)
            return
        }
    }
    
}

extension LoginPresenter: IPresenterForFireBaseManager {
    func presentError(error: FailureCases) {
        self.view?.showErrrorAlert(withMessage: error)
    }
    
    
    
}

