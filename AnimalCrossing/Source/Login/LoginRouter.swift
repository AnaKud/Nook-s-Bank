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

	func goToNextWithoutLogin() {
		let mainRouter = MainRouter(screenType: .unloggined)
		let nextVC = mainRouter.returnController()
		self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
	}

	func goToNextWithLogin() {
		let mainRouter = MainRouter(screenType: .loggined)
		let nextVC = mainRouter.returnController()
		self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
	}

	func goToRegisterView() {
		let nextVC = RegisterUserAssemly.build()
		let nextVCNavigationController = UINavigationController(rootViewController: nextVC)
		nextVCNavigationController.modalPresentationStyle = .fullScreen
		self.viewController?.present(nextVCNavigationController, animated: false)
	}

	func goToNextWithoutInternetConnection() {
		let mainRouter = MainRouter(screenType: .unloggined, tag: 1)
		let nextVC = mainRouter.returnController()
		self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
	}
}
