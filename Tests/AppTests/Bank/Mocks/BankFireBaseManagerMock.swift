// BankFireBaseManagerMock.swift
// Created by Anastasiya Kudasheva on 04.03.2022

@testable import AnimalCrossingBank

class BankFireBaseManagerMock: IBankDataBaseManager {
	var expenses = [ExpenseTransition(ExpenseDto(value: 100,
												 currencyType: .bells,
												 operationType: .plus))]
	var balance: Int
	var bankPresenter: IBankPresenter?

	private var bankAccount: BankAccountDto {
		BankAccountDto(bells: CurrencyDto(
			object: CurrencyTransition(account: self.balance,
									   type: .bells,
									   expenses: self.expenses)))
	}

	init(balance: Int = 0) {
		self.balance = balance
	}

	func addExpenseOrIncome(_ model: ExpenseDto, currency: CurrencyType) -> Bool {
		self.expenses.append(ExpenseTransition(model))
		if model.operationType == "plus" {
			self.balance += model.value ?? 0
		} else {
			self.balance -= model.value ?? 0
		}
		return true
	}

	func checkDBAvailability(completion: @escaping (ACVoidResult<BankError>) -> Void) {
		completion(.success)
	}

	func updateAccountValue(newValue: Int, currency: CurrencyType) -> Bool {
		self.balance = newValue
		return true
	}

	func currentBankAccountFromFB(completion: @escaping (BankAccountDto) -> Void) {
		completion(self.bankAccount)
	}
}
