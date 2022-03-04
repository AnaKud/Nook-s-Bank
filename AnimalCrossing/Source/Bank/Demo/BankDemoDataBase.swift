// BankDemoDataBase.swift
// Created by Anastasiya Kudasheva on 16.12.2021

class BankDemoDataBase: IBankDataBaseManager {
	private var account = makeDemoAccount()

	var bankPresenter: IBankPresenter?

	func currentBankAccountFromFB(completion: @escaping (ACResult<BankAccountDto, BankError>) -> Void) {
		completion(.success(self.account))
	}

	func addExpenseOrIncome(_ model: ExpenseDTO, currency: CurrencyType) {
		self.account.bells?.expenses.append(model)
	}

	func getUser() -> IUser? {
		self.makeDemoUser()
	}

	func updateAccountValue(newValue: Int, currency: CurrencyType) {
		self.account.bells?.account = newValue
	}
}

private extension BankDemoDataBase {
	static func makeDemoAccount() -> BankAccountDto {
		let expenses = [
			ExpenseDTO(value: 1452, operationType: .plus),
			ExpenseDTO(value: 1248, operationType: .minus),
			ExpenseDTO(value: 3248, operationType: .minus),
			ExpenseDTO(value: 74_532, operationType: .plus),
			ExpenseDTO(value: 29_012, operationType: .plus)
		]
		return BankAccountDto(loan: nil,
							  poki: nil,
							  bells: CurrencyDto(account: 100_500,
												 type: "bells",
												 expenses: expenses),
							  miles: nil)
	}

	func makeDemoUser() -> IUser? {
		UserLocale(uid: "demoUserUid", email: "demoUser@mail.ru")
	}
}
