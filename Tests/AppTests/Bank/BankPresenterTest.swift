//
//  BankPresenter.swift
//  Created by Anastasiya Kudasheva on 15.12.2021

import XCTest
@testable import Firebase
@testable import AnimalCrossing

class BankPresenterTests: XCTestCase {
	private let dataBase = BankFireBaseManagerMock()
	private var router = BankRouterMock()
	private var presenter: BankPresenter!

	func testPresenterAddExpence() {
		self.presenter = self.makePresenter()
		self.presenter.loadView(view: BankViewControllerMock(value: 2, operationType: .plus))
		self.presenter.plusButtonTapped()
		XCTAssertEqual(2, self.dataBase.balance)
	}

	func testPresenterAddIncome() {
		self.dataBase.balance = 2
		self.presenter = self.makePresenter()
		self.presenter.loadView(view: BankViewControllerMock(value: 1, operationType: .minus))
		self.presenter.plusButtonTapped()
		XCTAssertEqual(1, self.dataBase.balance)
	}

	func testPresenterNotAddIncomeBalanceIsZero() {
		self.presenter = self.makePresenter()
		self.presenter.loadView(view: BankViewControllerMock(value: 2, operationType: .minus))
		self.presenter.plusButtonTapped()
		XCTAssertEqual(0, self.dataBase.balance)
	}

	func testPresenterGetCurrentUser() {
		self.presenter = self.makePresenter()
		self.presenter.getCurrentUser()
		XCTAssertEqual("unitTest@mail.ru", self.dataBase.user.email)
		XCTAssertEqual("unidUid", self.dataBase.user.uid)
	}

	func testDisplayCurrentAccount() {
		self.presenter = self.makePresenter()
		self.dataBase.balance = 100
		XCTAssertEqual("100", "\(self.dataBase.balance)")
	}

	func testPresenterReturnExpensesCount() {
		self.presenter = self.makePresenter()
		self.presenter.getCurrentUser()
		XCTAssertEqual(1, self.presenter.returnCollectionCount())
	}

	func testPresenterReturnExpensesItem() {
		self.presenter = self.makePresenter()
		self.presenter.getCurrentUser()
		XCTAssertEqual(100, self.presenter.returnCollectionItem(index: 0).value)
	}
}

private extension BankPresenterTests {
	func makePresenter() -> BankPresenter {
		let presenter = BankPresenter(demoDataBase: self.dataBase,
									  router: self.router)
		presenter.getCurrentUser()
		return presenter
	}
}
