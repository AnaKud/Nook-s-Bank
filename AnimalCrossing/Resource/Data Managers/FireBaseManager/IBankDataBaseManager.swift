// IBankDataBaseManager.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import ACErrors
import Firebase
import Foundation

protocol IBankDataBaseManager {
	func addExpenseOrIncome(_ model: ExpenseDTO, currency: CurrencyType)
	func getUser() -> IUser?
	func updateAccountValue(newValue: Int, currency: CurrencyType)
	func currentBankAccountFromFB(completion: @escaping (ACResult<BankAccountDto, BankError>) -> Void)
}

protocol ITurnipFireBaseManager {
	func addExpenseOrIncome(_ model: ExpenseDTO, currency: CurrencyType)
}

extension FireBaseManager: ITurnipFireBaseManager {
}

extension FireBaseManager: IBankDataBaseManager {
	func getUser() -> IUser? {
		guard let currentUser = Auth.auth().currentUser,
			  let user = UserLocale(user: currentUser)
		else { return nil }
		self.refBankAccount = self.setupRefBankAccount(for: user.uid)
		return user
	}

	func currentBankAccountFromFB(completion: @escaping (ACResult<BankAccountDto, BankError>) -> Void) {
		self.refBankAccount?.observe(.value, with: { snapshot in
			guard let value = snapshot.value as? BankAccountDto
			else {
				return completion(.failure(.noBankData))
			}
			completion(.success(value))
		})
	}

	func updateAccountValue(newValue: Int, currency: CurrencyType) {
		self.refBankAccount?.updateChildValues(["currentValue": newValue])
	}

	func addExpenseOrIncome(_ model: ExpenseDTO, currency: CurrencyType) {
		let refOnCurrentFb = self.refBankAccount?.child("expenses")
		refOnCurrentFb?.setValue(model.makeDictionary())
	}

	func setupRefBankAccount(for id: String) -> DatabaseReference? {
		return self.refUser.child(id).child("currentAcount")
	}
}
