// BankWorker.swift
// Created by Anastasiya Kudasheva on 12.03.2022

protocol IBankWorker {
	func checkDataAvailability(completion: @escaping (ACVoidResult<BankError>) -> Void)
	func getCurrentUser(completion: @escaping (BankAccountTransition) -> Void)
	func addExpense(_ expense: ExpenseTransition,
					currentAccountValue: Int?,
					completion: @escaping (ACVoidResult<AddingExpensesError>) -> Void) 
}

class BankWorker {
	private let dataBaseManager: IBankDataBaseManager

	init(dataBaseManager: IBankDataBaseManager) {
		self.dataBaseManager = dataBaseManager
	}
}

extension BankWorker: IBankWorker {
	func checkDataAvailability(completion: @escaping (ACVoidResult<BankError>) -> Void) {
		self.dataBaseManager.checkDBAvailability(completion: completion)
	}

	func getCurrentUser(completion: @escaping (BankAccountTransition) -> Void) {
		self.dataBaseManager.currentBankAccountFromFB { dto in
			completion(BankAccountTransition(dto))
		}
	}

	func addExpense(_ expense: ExpenseTransition,
					currentAccountValue: Int?,
					completion: @escaping (ACVoidResult<AddingExpensesError>) -> Void) {
		var accountValue = currentAccountValue ?? 0
		let expenseForFir = ExpenseDto(from: expense)
		switch expense.operationType {
		case .plus:
			accountValue += (expense.value ?? 0)
		case .minus:
			guard (accountValue - (expense.value ?? 0)) >= 0 else { return completion(.failure(.cantBeLowerThanZero)) }
			accountValue -= (expense.value ?? 0)
		}
		if self.updateCurrentAccountValue(accountValue), self.addExpenseToFb(expense: expenseForFir) {
			completion(.success)
		} else {
			completion(.failure(.dbFailure))
		}
	}
}

private extension BankWorker {
	func updateCurrentAccountValue(_ value: Int) -> Bool {
		self.dataBaseManager.updateAccountValue(newValue: value, currency: .bells)
	}

	func addExpenseToFb(expense: ExpenseDto) -> Bool {
		self.dataBaseManager.addExpenseOrIncome(expense, currency: .bells)
	}
}
