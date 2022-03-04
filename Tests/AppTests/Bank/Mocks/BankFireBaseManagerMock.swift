// BankFireBaseManagerMock.swift
// Created by Anastasiya Kudasheva on 04.03.2022

@testable import AnimalCrossing

class BankFireBaseManagerMock: IBankDataBaseManager {
	var user: IUser!
	var expenses = [ExpenseTransition(ExpenseDTO(value: 100,
												 operationType: .plus))]
	var balance: Int = 0
	var bankPresenter: IBankPresenter?

	func addExpenseOrIncome(_ model: ExpenseDTO, currency: CurrencyType) {
		print(self.balance)
		self.expenses.append(ExpenseTransition(model))
		switch model.operationType {
		case .plus:
			self.balance += model.value
		default:
			self.balance -= model.value
		}
		print(self.balance)
	}

	func getUser() -> IUser? {
		self.user = UserMock()
		return self.user
	}

	func updateAccountValue(newValue: Int, currency: CurrencyType) {
		self.balance = newValue
	}

	func currentBankAccountFromFB(completion: @escaping (ACResult<BankAccountDto, BankError>) -> Void) {
		let bellsAccount = CurrencyTransition(account: self.balance, type: .bells, expenses: self.expenses)
		completion(.success(BankAccountDto(loan: nil,
										   poki: nil,
										   bells: CurrencyDto(object: bellsAccount),
										   miles: nil)))
	}

	func currentExpensesFromFB(completion: @escaping ([ExpenseDTO]) -> Void) {
		let result: [ExpenseDTO] = self.expenses.compactMap { expense in
			ExpenseDTO(from: expense)
		}
		completion(result)
	}
}
