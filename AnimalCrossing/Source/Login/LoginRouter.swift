// LoginRouter.swift
// Created by Anastasiya Kudasheva on 10.06.2021.

import UIKit

protocol ILoginViewControllerSender {
	func setupVC(_ vc: LoginViewController)
}

protocol ILoginRouter: AnyObject, ILoginViewControllerSender {
	func goToNextWithoutLogin()
	func goToNextWithoutInternetConnection()
	func goToNextWithLogin()
	func goToRegisterView()
}

class LoginRouter {
	private weak var viewController: LoginViewController?
}

extension LoginRouter: ILoginRouter {
	func setupVC(_ vc: LoginViewController) {
		self.viewController = vc
	}

	func goToRegisterView() {
		let nextVC = UserSettingsAssemly.build()
		let nextVCNavigationController = UINavigationController(rootViewController: nextVC)
		nextVCNavigationController.modalPresentationStyle = .fullScreen
		self.viewController?.present(nextVCNavigationController, animated: false)
	}

	func goToNextWithoutLogin() {
//		FireBaseManager.shared.login(withEmail: "Ana@ya.ru",
//								   withPassword: "Ana123!",
//								   completion: { _ in })
		let mainRouter = MainRouter(screenType: .unloggined)
		self.goToTabbar(mainRouter)
	}

	func goToNextWithLogin() {
		let mainRouter = MainRouter(screenType: .loggined)
		self.goToTabbar(mainRouter)
	}

	func goToNextWithoutInternetConnection() {
		let mainRouter = MainRouter(screenType: .unloggined, tag: 1)
		self.goToTabbar(mainRouter)
	}
}

private extension LoginRouter {
	func goToTabbar(_ mainRouter: MainRouter) {
		let nextVC = mainRouter.returnController()
		nextVC.modalPresentationStyle = .fullScreen
		self.viewController?.present(nextVC, animated: true, completion: nil)
	}
}
