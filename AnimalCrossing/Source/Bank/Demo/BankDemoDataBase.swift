// BankDemoDataBase.swift
// Created by Anastasiya Kudasheva on 16.12.2021

class BankDemoDataBase: IBankDataBaseManager {
	private lazy var account = Self.makeDemoAccount()

	func checkDBAvailability(completion: @escaping (ACVoidResult<BankError>) -> Void) {
		completion(.success)
	}

	func currentBankAccountFromFB(completion: @escaping (BankAccountDto) -> Void) {
		completion(self.account)
	}

	func currentBankAccountFromFB(completion: @escaping (ACResult<BankAccountDto, BankError>) -> Void) {
		completion(.success(self.account))
	}

	func addExpenseOrIncome(_ model: ExpenseDto, currency: CurrencyType) -> Bool {
		guard self.account.bells != nil else { return false }
		self.account.bells?.expenses?.append(model)
		return true
	}

	func updateAccountValue(newValue: Int, currency: CurrencyType) -> Bool {
		guard self.account.bells != nil else { return false }
		self.account.bells?.account = newValue
		return true
	}
}

private extension BankDemoDataBase {
	static func makeDemoAccount() -> BankAccountDto {
		let expenses = [
			ExpenseDto(value: 1452, currencyType: .bells, operationType: .plus),
			ExpenseDto(value: 1248, currencyType: .bells, operationType: .minus),
			ExpenseDto(value: 3248, currencyType: .bells, operationType: .minus),
			ExpenseDto(value: 74_532, currencyType: .bells, operationType: .plus),
			ExpenseDto(value: 29_012, currencyType: .bells, operationType: .plus)
		]
		return BankAccountDto(
							  bells: CurrencyDto(account: 0,
												 type: "bells",
												 expenses: expenses)
							  )
	}
}
