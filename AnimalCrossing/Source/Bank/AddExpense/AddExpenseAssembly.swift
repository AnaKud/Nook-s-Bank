// AddExpenseAssembly.swift
// Created by Anastasiya Kudasheva on 26.03.2022

enum AddExpenseAssembly {
	static func build(screenType: LoginedScreenType,
					  operationType: OperationType,
					  completion: @escaping (ExpenseTransition) -> Void)
	-> AddExpenseViewController {
		let presenter = AddExpensePresenter(screenType: screenType,
											operationType: operationType,
											router: AddExpenseRouter(),
											completion: completion)
		return AddExpenseViewController(screenType: screenType, presenter: presenter)
	}
}
