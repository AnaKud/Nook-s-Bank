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
		let nextVC = RegisterUserAssemly.build()
		let nextVCNavigationController = UINavigationController(rootViewController: nextVC)
		nextVCNavigationController.modalPresentationStyle = .fullScreen
		self.viewController?.present(nextVCNavigationController, animated: false)
	}

	func goToNextWithoutLogin() {
//		FireBaseManager.shared.login(withEmail: "Ana@ya.ru",
//								   withPassword: "Ana123!",
//								   completion: { _ in })
		let mainAssembly = MainAssembly(screenType: .unlogined)
		self.goToTabbar(mainAssembly)
	}

	func goToNextWithLogin() {
		let mainAssembly = MainAssembly(screenType: .logined(.main))
		self.goToTabbar(mainAssembly)
	}

	func goToNextWithoutInternetConnection() {
		let mainAssembly = MainAssembly(screenType: .unlogined, tag: 1)
		self.goToTabbar(mainAssembly)
	}
}

private extension LoginRouter {
	func goToTabbar(_ mainAssembly: MainAssembly) {
		let nextVC = mainAssembly.returnController()
		nextVC.modalPresentationStyle = .fullScreen
		self.viewController?.present(nextVC, animated: true, completion: nil)
	}
}
