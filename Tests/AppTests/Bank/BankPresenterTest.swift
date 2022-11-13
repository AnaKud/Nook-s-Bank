//
//  BankPresenter.swift
//  Created by Anastasiya Kudasheva on 15.12.2021

import XCTest
@testable import Firebase
@testable import ACErrors
@testable import AnimalCrossingBank

class BankPresenterTests: XCTestCase {
	private let router = BankRouterMock()
	private var interactor: BankInteractor!
	private let presenter = BankPresenterMock()
	private let view = BankViewControllerMock()

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
		self.interactor = nil
	}

	func testPresenterAddExpence() {
		self.interactor = self.makeInteractor()
		self.interactor.addExpenseOrIncome(ExpenseTransition(value: 2,
															 currencyType: .bells, operationType: .plus, expenseType: .artwork))
		self.interactor.plusButtonTapped()
		XCTAssertEqual("2", self.presenter.balanceValue)
	}

	func testPresenterAddIncome() {
		self.interactor = self.makeInteractor(withBalance: 2)
		self.interactor.loadVC(self.view)
		self.interactor.addExpenseOrIncome(ExpenseTransition(value: 1,
															 currencyType: .bells,
															 operationType: .minus,
															 expenseType: .other))
		XCTAssertEqual("1", self.presenter.balanceValue)
	}

	func testPresenterNotAddIncomeBalanceIsZero() {
		self.interactor = self.makeInteractor()
		self.interactor.loadVC(self.view)
		self.interactor.addExpenseOrIncome(ExpenseTransition(value: 2,
															 currencyType: .bells,
															 operationType: .minus, expenseType: .artwork))
		XCTAssertEqual("0", self.presenter.balanceValue)
	}

	func testDisplayCurrentAccount() {
		self.interactor = self.makeInteractor(withBalance: 100)
		self.interactor.loadVC(self.view)
		XCTAssertEqual("100", self.presenter.balanceValue)
	}

	func testPresenterReturnExpensesCount() {
		self.interactor = self.makeInteractor()
		self.interactor.loadVC(self.view)
		XCTAssertEqual(1, self.interactor.returnCollectionCount())
	}

	func testPresenterReturnExpensesItem() {
		self.interactor = self.makeInteractor()
		self.interactor.loadVC(self.view)
		XCTAssertEqual("+100", self.interactor.returnCollectionItem(index: 0).expenseText)
	}
}

private extension BankPresenterTests {
	func makeInteractor(withBalance balance: Int = 0) -> BankInteractor {
		return BankInteractor(presenter: self.presenter,
							  router: self.router,
							  worker: BankWorkerMock(balance: balance))
	}
}

class BankPresenterMock: IBankPresenter {
	private(set) var balanceValue = ""

	func loadVC(_ view: IBankViewController) { }

	func showAccountValue(_ value: String) {
		self.balanceValue = value
	}

	func refreshCollectionView() { }

	func showAddExpenseAlert() { }

	func showErrorAlert(error: ACError, handler: (() -> Void)?) { }
}

class BankWorkerMock: IBankWorker {
	private(set) var expenses = [ExpenseTransition(ExpenseDto(value: 100,
															  currencyType: .bells,
															  operationType: .plus))]

	private(set) var balance: Int

	private var bankAccount: BankAccountTransition {
		BankAccountTransition(loan: nil,
							  poki: nil,
							  bells: CurrencyTransition(account: self.balance,
														type: .bells,
										 expenses: self.expenses),
							  miles: nil)
	}

	init(balance: Int = 0) {
		self.balance = balance
	}

	func checkDataAvailability(completion: @escaping (ACVoidResult<BankError>) -> Void) {
		completion(.success)
	}

	func getCurrentUser(completion: @escaping (BankAccountTransition) -> Void) {
		completion(self.bankAccount)
	}

	func addExpense(_ expense: ExpenseTransition,
					currentAccountValue: Int?,
					completion: @escaping (ACVoidResult<AddingExpensesError>) -> Void) {
		var accountValue = currentAccountValue ?? 0
		switch expense.operationType {
		case .plus:
			accountValue += (expense.value ?? 0)
		case .minus:
			guard (accountValue - (expense.value ?? 0)) >= 0 else { return completion(.failure(.cantBeLowerThanZero)) }
			accountValue -= (expense.value ?? 0)
		}
		self.expenses.append(expense)
		self.balance = accountValue
		completion(.success)
	}
}
