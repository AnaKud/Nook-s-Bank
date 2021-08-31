//
//  LoginPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation

protocol ILoginPresenter: AnyObject {
	var viewController: ILoginViewController? { get set }
	func presentScreen(forScreenType screenType: ScreenTypes)
//    var screenType: ScreenTypes { get set }
//    var titleForViewContoller: String { get set }
//    func loginButtonTapped(email: String?, password: String?)
//    func openWithoutLogin()
//    func openWithLogin()
//    func openForRegister()
//    func registerButtonTapped(email: String?, password: String?)
//    func registerUser(withUserName name: String, withEmail email: String, withPassword password: String)
//    func viewDidLoad(view: LoginViewController)
//    func showWarningLabel(withWarningText warningText: String)
//    func presentError(error: FailureCases)
//    func forgetButtonTapped()
//    func touchIdButtonTapped()
//	func logout()
}

class LoginPresenter {
   // var screenType: ScreenTypes = .loginScreen
    // var titleForViewContoller: String = ""
  //  var fireBaseManager: ILoginFireBaseManager
//    var router: ILoginRouter
//    var keychainService: IKeychainService
	weak var viewController: ILoginViewController?

//    init(view: ILoginViewController) {
//       // self.fireBaseManager = fireBaseManager
//      //  self.router = router
//		self.view = view
//        //self.keychainService = keychainService
//        //self.setupScreenType()
//    }

}

extension LoginPresenter: ILoginPresenter {
	func presentScreen(forScreenType screenType: ScreenTypes) {
		if viewController == nil {
			print("view is nil")
		}
		self.viewController?.updateScreenType(screenType: .loginScreen)
		switch screenType {
		case .loginScreen:
			self.viewController?.setupFullLoginView()
		default:
			self.viewController?.setupSimpleLoginView()
		}
	}

//	func logout() {
//		print("log")
//	}
//
//    func loginButtonTapped(email: String?, password: String?) {
//        self.checkEmail(email: email)
//        guard let email = email, let password = password, password != "" else {
//            self.showWarningLabel(withWarningText: LoginWarnings.incorrectInfo.rawValue)
//            return
//        }
//        self.fireBaseManager.login(withEmail: email, withPassword: password)
//        self.keychainService.savePassword(account: email, password: password)
//    }
//
//    func openWithoutLogin() {
//        UserDefaults.standard.setValue(true, forKey: "simpleLogin")
//        self.screenType = .unloggined
//        self.titleForViewContoller = AppTitle.nookBank
//        self.router.goToNextWithoutLogin(withScreenType: screenType)
//    }
//
//    func openWithLogin() {
//        self.screenType = .loggined
//        self.titleForViewContoller = AppTitle.nookBank
//        self.router.goToNextWithLogin(withScreenType: screenType)
//    }
//
//    func registerButtonTapped(email: String?, password: String?) {
//        self.checkEmail(email: email)
//        guard let email = email, let password = password, password != "" else {
//            self.showWarningLabel(withWarningText: LoginWarnings.incorrectEmail.rawValue)
//            return
//        }
//        self.view?.showUserNameAlert(withEmail: email, withPassword: password)
//    }
//
//    func registerUser(withUserName name: String, withEmail email: String, withPassword password: String) {
//        self.fireBaseManager.register(withUserName: name, withEmail: email, withPassword: password)
//    }
//
//    func openForRegister() {
//        self.showWarningLabel(withWarningText: LoginWarnings.sucssessRegister.rawValue)
//    }
//
//    func viewDidLoad(view: LoginViewController) {
//        self.view = view
//        self.setupView()
//    }
//
//    func showWarningLabel(withWarningText warningText: String) {
//        self.view?.showWarningLabel(withWarningText: warningText)
//    }
//
//    func forgetButtonTapped() {
//        print("forgetButtonTapped")
//        UserDefaults.standard.setValue(false, forKey: "simpleLogin")
//        self.setupScreenType()
//        self.router.reloadLoginView(withScreenType: screenType)
//    }
//
//    func touchIdButtonTapped() {
//        print("touchIdButtonTapped")
//        UserDefaults.standard.setValue(true, forKey: "simpleLogin")
//        print("userDef \(UserDefaults.standard.value(forKey: "simpleLogin"))")
//        DeviceOwnerAuthentication.shared.authenticationRequest { result in
//            print(result)
//        }
//    }
//
//    private func setupScreenType() {
//		print("userDef \(UserDefaults.standard.value(forKey: "simpleLogin"))")
//		guard let value = UserDefaults.standard.value(forKey: "simpleLogin") as? Bool else {
//			screenType = .loginScreen
//			return
//		}
//		if value == true {
//			screenType = .other
//		} else {
//			screenType = .loginScreen
//		}
//	}
//
//    private func setupView() {
//        switch screenType {
//        case .loginScreen:
//            self.view?.setupFullLoginView()
//        default:
//            self.view?.setupSimpleLoginView()
//        }
//    }
//
//    private func checkEmail(email: String?) {
//        guard let email = email,
//              email != "",
//              email.contains("@"),
//              email.contains(".")
//        else {
//            self.showWarningLabel(withWarningText: LoginWarnings.incorrectInfo.rawValue)
//            return
//        }
//    }
// }
//
// extension LoginPresenter: IPresenterForFireBaseManager {
//    func presentError(error: FailureCases) {
//        self.view?.showErrorAlert(withMessage: error)
//    }
}
/*
//
//  LoginPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation

protocol ILoginPresenter {
	var screenType: ScreenTypes { get set }
	var titleForViewContoller: String { get set }
	func loginButtonTapped(email: String?, password: String?)
	func openWithoutLogin()
	func openWithLogin()
	func openForRegister()
	func registerButtonTapped(email: String?, password: String?)
	func registerUser(withUserName name: String, withEmail email: String, withPassword password: String)
	func viewDidLoad(view: LoginViewController)
	func showWarningLabel(withWarningText warningText: String)
	func presentError(error: FailureCases)
	func forgetButtonTapped()
	func touchIdButtonTapped()
	func logout()
}

class LoginPresenter {
	var screenType: ScreenTypes = .loginScreen
	var titleForViewContoller: String = ""
	var fireBaseManager: ILoginFireBaseManager
	var router: ILoginRouter
	var keychainService: IKeychainService
	var view: ILoginViewController?

	init(fireBaseManager: ILoginFireBaseManager, router: ILoginRouter, keychainService: IKeychainService) {
		self.fireBaseManager = fireBaseManager
		self.router = router
		self.keychainService = keychainService
		self.setupScreenType()
	}
}

extension LoginPresenter: ILoginPresenter {
	func logout() {
		print("log")
	}

	func loginButtonTapped(email: String?, password: String?) {
		self.checkEmail(email: email)
		guard let email = email, let password = password, password != "" else {
			self.showWarningLabel(withWarningText: LoginWarnings.incorrectInfo.rawValue)
			return
		}
		self.fireBaseManager.login(withEmail: email, withPassword: password)
		self.keychainService.savePassword(account: email, password: password)
	}

	func openWithoutLogin() {
		UserDefaults.standard.setValue(true, forKey: "simpleLogin")
		self.screenType = .unloggined
		self.titleForViewContoller = AppTitle.nookBank
		self.router.goToNextWithoutLogin(withScreenType: screenType)
	}

	func openWithLogin() {
		self.screenType = .loggined
		self.titleForViewContoller = AppTitle.nookBank
		self.router.goToNextWithLogin(withScreenType: screenType)
	}

	func registerButtonTapped(email: String?, password: String?) {
		self.checkEmail(email: email)
		guard let email = email, let password = password, password != "" else {
			self.showWarningLabel(withWarningText: LoginWarnings.incorrectEmail.rawValue)
			return
		}
		self.view?.showUserNameAlert(withEmail: email, withPassword: password)
	}

	func registerUser(withUserName name: String, withEmail email: String, withPassword password: String) {
		self.fireBaseManager.register(withUserName: name, withEmail: email, withPassword: password)
	}

	func openForRegister() {
		self.showWarningLabel(withWarningText: LoginWarnings.sucssessRegister.rawValue)
	}

	func viewDidLoad(view: LoginViewController) {
		self.view = view
		self.setupView()
	}

	func showWarningLabel(withWarningText warningText: String) {
		self.view?.showWarningLabel(withWarningText: warningText)
	}

	func forgetButtonTapped() {
		print("forgetButtonTapped")
		UserDefaults.standard.setValue(false, forKey: "simpleLogin")
		self.setupScreenType()
		self.router.reloadLoginView(withScreenType: screenType)
	}

	func touchIdButtonTapped() {
		print("touchIdButtonTapped")
		UserDefaults.standard.setValue(true, forKey: "simpleLogin")
		  //  .setValue("true", forKey: "simpleLogin")
		print("userDef \(UserDefaults.standard.value(forKey: "simpleLogin"))")
		DeviceOwnerAuthentication.shared.authenticationRequest { result in
			print(result)
		}
	}

	private func setupScreenType() {
		print("userDef \(UserDefaults.standard.value(forKey: "simpleLogin"))")
		guard let value = UserDefaults.standard.value(forKey: "simpleLogin") as? Bool else {
													  screenType = .loginScreen
													  return
		}
		if value == true {
			screenType = .other
		} else {
			screenType = .loginScreen
		}
	}

	private func setupView() {
		switch screenType {
		case .loginScreen:
			self.view?.setupFullLoginView()
		default:
			self.view?.setupSimpleLoginView()
		}
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
		self.view?.showErrorAlert(withMessage: error)
	}
}
*/
