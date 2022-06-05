// AddExpenseRouter.swift
// Created by Anastasiya Kudasheva on 27.03.2022

final class AddExpenseRouter {
	private var navigator: INavigator?

	func setNavigator(_ navigator: INavigator?) {
		self.navigator = navigator
	}

	func dismissBack(completion: (() -> Void)? = nil) {
		self.navigator?.dismissVC(completion: completion)
	}
}
