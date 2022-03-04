// BankPresenter.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import Foundation

protocol IBankPresenter {
	var user: IUser? { get set }
	var account: BankViewModel? { get set }
	var screenType: ScreenTypes? { get set }

	func getCurrentUser()

	func loadView(view: IBankViewController)
	func plusButtonTapped()
	func returnCurrentAccountValue() -> String
	func returnCollectionCount() -> Int
	func returnCollectionItem(index: Int) -> ExpenseViewModel
}

class BankPresenter {
	var screenType: ScreenTypes?
	var view: IBankViewController?
	var account: BankViewModel?
	var user: IUser?
	var daseManager: IBankDataBaseManager
	var router: IBankRouter

	init(demoDataBase: IBankDataBaseManager, router: IBankRouter) {
		self.daseManager = demoDataBase
		self.router = router
		self.getCurrentUser()
	}
}

extension BankPresenter: IBankPresenter {
	func getCurrentUser() {
		self.user = self.daseManager.getUser()
		self.daseManager.currentBankAccountFromFB { result in
			switch result {
			case .success(let dto):
				let account = BankAccountTransition(dto)
				self.account = BankViewModel(object: account)
			case .failure(let error):
				print(error.humanfriendlyMessage)
			}
		}
	}

	func plusButtonTapped() {
		self.view?.showAddExpenseAlert { expense in
			self.addExpense(expense: expense)
		}
	}

	func loadView(view: IBankViewController) {
		self.view = view
		self.view?.refreshView(currentValue: self.returnCurrentAccountValue())
	}

	func returnCurrentAccountValue() -> String {
		return String(describing: self.account?.bells?.account)
	}

	func returnCollectionCount() -> Int {
		return self.account?.bells?.expenses.count ?? 0
	}

	func returnCollectionItem(index: Int) -> ExpenseViewModel {
		let item = self.account?.bells?.expenses[index]
		?? ExpenseViewModel(date: "", value: 0, operationType: .plus, expenseType: .other)
		return item
	}
}

private extension BankPresenter {
	func addExpense(expense: ExpenseTransition) {
		let expenseForFir = ExpenseDTO(from: expense)
		guard let account = self.account else { return }
		switch expense.operationType {
		case .plus:
			account.bells?.account += expense.value
		case .minus:
			guard account.bells?.account ?? 0 - expense.value > 0 else { return }
			account.bells?.account -= expense.value
		}
		account.bells?.expenses.insert(ExpenseViewModel(object: expense), at: 0)
		self.addExpenseToFb(expense: expenseForFir)
		self.updateCurrentAccountValue()
		self.refreshView()
	}

	func updateCurrentAccountValue() {
		guard let account = self.account?.bells?.account else { return }
		self.daseManager.updateAccountValue(newValue: account, currency: .bells)
	}

	func sortExpenses(expensesInput: [ExpenseDTO]?) -> [ExpenseDTO]? {
		let result = expensesInput?.sorted(by: {
			let firstDate = Date(timeIntervalSince1970: $0.date)
			let secondDate = Date(timeIntervalSince1970: $1.date)
			return firstDate.compare(secondDate) == .orderedDescending
		}) ?? [ExpenseDTO]()
		return result
	}

	func refreshView() {
		let displayedValue = self.returnCurrentAccountValue()
		self.view?.refreshView(currentValue: displayedValue)
	}

	func addExpenseToFb(expense: ExpenseDTO) {
		self.daseManager.addExpenseOrIncome(expense, currency: .bells)
	}
}
