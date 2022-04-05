// BankInteractor.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

protocol IBankViewDelegate: AnyObject {
	func returnCollectionCount() -> Int
	func returnCollectionItem(index: Int) -> ExpenseViewModel
}

protocol IBankInteractor: IBankBellsViewCallback {
	func loadVC(_ view: IBankViewController)
	func plusButtonTapped()
	func addExpenseOrIncome(_ value: ExpenseTransition)
	func returnCurrentAccountValue() -> String
}

class BankInteractor {
	private var viewController: IBankViewController?
	private var bankVM: BankViewModel?
	private let router: IBankRouter
	private let presenter: IBankPresenter
	private let worker: IBankWorker

	init(presenter: IBankPresenter, router: IBankRouter, worker: IBankWorker) {
		self.router = router
		self.presenter = presenter
		self.worker = worker
	}
}

extension BankInteractor: IBankInteractor {
	func plusButtonTapped() {
		let completion: (ExpenseTransition) -> Void = { [weak self] expenseTransition in
			self?.addExpenseOrIncome(expenseTransition)
		}

		self.router.presentAddExpenseView(screenType: .bells,
										  operationType: .plus,
										  completion: completion)
	}

	func minusButtonTapped() {
		let completion: (ExpenseTransition) -> Void = { [weak self] expenseTransition in
			self?.addExpenseOrIncome(expenseTransition)
		}

		self.router.presentAddExpenseView(screenType: .bells,
										  operationType: .minus,
										  completion: completion)
	}

	func loadVC(_ vc: IBankViewController) {
		self.viewController = vc
		self.router.loadNavigator(vc)
		self.worker.checkDataAvailability { result in
			switch result {
			case .success:
				self.presenter.loadVC(vc)
				self.getCurrentUser()
			case .failure(let error):
				self.presenter.showErrorAlert(error: error, handler: nil)
			}
		}
	}

	func returnCurrentAccountValue() -> String {
		guard let value = self.bankVM?.bells?.account else { return "" }
		return "\(value)"
	}

	func returnCollectionCount() -> Int {
		return self.bankVM?.bells?.expenses.count ?? 0
	}

	func returnCollectionItem(index: Int) -> ExpenseViewModel {
		let item = self.bankVM?.bells?.expenses[index]
		?? ExpenseViewModel(date: "", value: 0, currencyType: .bells, operationType: .plus, expenseType: .other)
		return item
	}

	func addExpenseOrIncome(_ value: ExpenseTransition) {
		self.worker.addExpense(
			value,
			currentAccountValue: self.bankVM?.bells?.account
		) { [weak self] result in
			switch result {
			case .success:
				self?.getCurrentUser()
			case .failure(let error):
				self?.presenter.showErrorAlert(error: error, handler: nil)
			}
		}
	}
}

private extension BankInteractor {
	func getCurrentUser() {
		self.worker.getCurrentUser { [weak self] account in
			guard let self = self else { return }
			self.bankVM = BankViewModel(object: account)
			self.refreshControls()
		}
	}

	func refreshControls() {
		self.presenter.refreshCollectionView()
		let currentValue = self.returnCurrentAccountValue()
		self.presenter.showAccountValue(currentValue)
	}
}

enum AddingExpensesError: ACError {
	case cantBeLowerThanZero
	case dbFailure

	var humanfriendlyTitle: String? { return nil }

	var humanfriendlyMessage: String {
		switch self {
		case .cantBeLowerThanZero:
			return "Your expense higher than current account"
		case .dbFailure:
			return "Unexpected database error. Try repeat later"
		}
	}
}
