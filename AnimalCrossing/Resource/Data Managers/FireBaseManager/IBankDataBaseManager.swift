// IBankDataBaseManager.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import ACErrors
import Firebase
import Foundation

// swiftlint:disable all

protocol IBankDataBaseManager {
	func addExpenseOrIncome(_ model: ExpenseDto, currency: CurrencyType) -> Bool
	func checkDBAvailability(completion: @escaping (ACVoidResult<BankError>) -> Void)
	func updateAccountValue(newValue: Int, currency: CurrencyType) -> Bool
	func currentBankAccountFromFB(completion: @escaping (BankAccountDto) -> Void)
}

protocol ITurnipFireBaseManager {
	func addExpenseOrIncome(_ model: ExpenseDto, currency: CurrencyType) -> Bool
}

extension FireBaseManager: ITurnipFireBaseManager {
}

extension FireBaseManager: IBankDataBaseManager {
	func checkDBAvailability(completion: @escaping (ACVoidResult<BankError>) -> Void) {
		guard let currentUser = Auth.auth().currentUser,
			  let user = UserLocale(user: currentUser)
		else { return completion(.failure(.noBankData)) }
		self.setupRefBankAccount(for: user.uid)
		completion(.success)
	}

	func currentBankAccountFromFB(completion: @escaping (BankAccountDto) -> Void) {
		self.refBankAccount?.observe(.value, with: { snapshot in
			completion(BankAccountDto(snapshot: snapshot))
		})
	}

	func updateAccountValue(newValue: Int,
							currency: CurrencyType) -> Bool {
		guard let refOnCurrentFb = self.refBankAccount else { return false }
		refOnCurrentFb.child(currency.name).updateChildValues(["account": newValue])
		return true
	}

	func addExpenseOrIncome(_ model: ExpenseDto,
							currency: CurrencyType) -> Bool {
		guard let refOnCurrentFb = self.refBankAccount else { return false }
		refOnCurrentFb
			.child(currency.name)
			.child("expenses")
			.child(model.uid!)
			.updateChildValues(model.makeDictionary())
		return true
	}

	func addLoanHistory(_ model: LoanHistoryDto) -> Bool {
		guard let refOnCurrentFb = self.refBankAccount else { return false }
		let key = "loan"
		refOnCurrentFb
			.child(key)
			.child("loanHistory")
			.child(model.uid)
			.setValue(model.makeDictionary())
		return true
	}
}

private extension FireBaseManager {
	func setupRefBankAccount(for id: String) {
		self.refBankAccount = self.refUser.child(id).child("bank")
	}

	func setupNewExpense(_ value: Int, currency: String) { }
}
