// RegisterUserRouter.swift
// Created by Anastasiya Kudasheva on 08.12.2021

protocol IRegisterUserRouter {
	func dismissVC()
}

class RegisterUserRouter {
	private weak var viewController: RegisterUserViewController?

	func setupVC(_ viewController: RegisterUserViewController) {
		self.viewController = viewController
	}

	func dismissVC() {
		self.viewController?.navigationController?.dismiss(animated: true)
	}
}
