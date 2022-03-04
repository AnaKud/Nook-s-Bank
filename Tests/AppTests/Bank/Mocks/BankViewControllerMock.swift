// BankViewControllerMock.swift
// Created by Anastasiya Kudasheva on 04.03.2022

@testable import AnimalCrossing

class BankViewControllerMock: IBankViewController {
	private let expense: ExpenseTransition

	init(value: Int, operationType: OperationType) {
		self.expense = ExpenseTransition(value: value,
										 operationType: operationType,
										 expenseType: ExpenseType.random())
	}

	func interfaceWithData() { }

	func refreshView(currentValue: String) { }

	func showAddExpenseAlert(expenseHandler: @escaping (ExpenseTransition) -> Void) {
		expenseHandler(self.expense)
	}

	var currentAccount: BankViewModel?
}
