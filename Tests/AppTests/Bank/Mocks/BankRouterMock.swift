// BankRouterMock.swift
// Created by Anastasiya Kudasheva on 04.03.2022

@testable import AnimalCrossing

class BankRouterMock: IBankRouter {
	var state: String = ""

	func popToViewController() {
		self.state = "popToViewController"
	}

	func loadNavigator(_ navigator: INavigator) {
		self.state = "vcLoaded"
	}

	func presentAddExpenseView(screenType: LoginedScreenType,
							   operationType: OperationType,
							   completion: @escaping (ExpenseTransition) -> Void) {
		self.state = "presentAddExpenseView"
	}
}
