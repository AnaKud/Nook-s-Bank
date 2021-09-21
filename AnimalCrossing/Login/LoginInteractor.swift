//
//  LoginInteractor.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 16.07.2021.
//

import Foundation

typealias ILoginInteractor = ILoginInteractorBusinessLogic & ILoginDataStore &
	UIFullLoginViewCallBack & UISimpleLoginViewCallBack

protocol ILoginInteractorBusinessLogic {
	func logout()

	func didLoadUI()
}

protocol ILoginDataStore {

}

protocol UISimpleLoginViewCallBack {
	func pinEndEditing(pin: String)
	func forgetButtonTapped()
	func touchIdButtonTapped()
}

protocol UIFullLoginViewCallBack {
	func loginButtonTapped(email: String?, password: String?)
	func continueButtonTapped()
	func registerButtonTapped(withUserName name: String?, email: String?, password: String?)
}

class LoginInteractor: ILoginInteractor {

	var presenter: ILoginPresenter
	var worker: LoginWorker
	var router: ILoginRouter
	init(presenter: ILoginPresenter, worker: LoginWorker, router: ILoginRouter) {
		self.presenter = presenter
		self.worker = worker
		self.router = router
	}

	func logout() {
		print("log")
	}

	func loginButtonTapped(email: String?, password: String?) {
		self.worker.loginWithFirebase(email: email, password: password)
		self.router.goToNextWithLogin(withScreenType: .loggined)
	}

	func continueButtonTapped() {
		print("UserDefaults.standard.setValue(true, forKey: simpleLogin)")
		UserDefaults.standard.setValue(true, forKey: "simpleLogin")
		self.router.goToNextWithoutLogin(withScreenType: .unloggined)
	}

	func registerButtonTapped(withUserName name: String?, email: String?, password: String?) {
		self.router.goToRegisterView()
		//self.worker.registerUser(withUserName: name, withEmail: email, withPassword: password)
	}

	func forgetButtonTapped() {
		print("forgetButtonTapped")
		UserDefaults.standard.setValue(false, forKey: "simpleLogin")
		let screenType = self.setupScreenType()
		self.router.reloadLoginView(withScreenType: screenType)
	}

	func pinEndEditing(pin: String) {
		print(pin)
		if pin == "000000" {
			self.continueButtonTapped()
		}
	}

	func touchIdButtonTapped() {
		print("touchIdButtonTapped")
		UserDefaults.standard.setValue(true, forKey: "simpleLogin")
		print("userDef \(UserDefaults.standard.value(forKey: "simpleLogin"))")
		self.worker.authenticationService.authenticationRequest { isLoggined in
			print(isLoggined)
			if isLoggined {
				DispatchQueue.main.async {
					self.continueButtonTapped()
				}
			}
		}
	}

	func didLoadUI() {
		let screenType = setupScreenType()
		self.presenter.presentScreen(forScreenType: screenType)
	}

	private func setupScreenType() -> ScreenTypes {
		print("userDef \(UserDefaults.standard.value(forKey: "simpleLogin"))")
		var screenType = ScreenTypes.loginScreen
		if let value = UserDefaults.standard.value(forKey: "simpleLogin") as? Bool, value == true {
			screenType = .other
		} else { screenType = ScreenTypes.loginScreen }

		print(screenType)
		return screenType
	}
}
