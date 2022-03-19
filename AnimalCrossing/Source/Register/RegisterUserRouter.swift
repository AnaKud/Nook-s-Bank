// RegisterUserRouter.swift
// Created by Anastasiya Kudasheva on 08.12.2021

protocol IRegisterUserRouter {
	func dismissVC()
}

class RegisterUserRouter {
	private weak var navigator: INavigator?

	func setupNavigator(_ navigator: INavigator) {
		self.navigator = navigator
	}

	func dismissVC() {
		self.navigator?.dismissVC()
	}
}
