// ExpenseViewModel.swift
// Created by Anastasiya Kudasheva on 16.12.2021

import class UIKit.UIColor

class ExpenseViewModel {
	let date: String
	let expenseText: String
	let currencyType: CurrencyType
	let expenseColor: UIColor?
	let expenseType: ExpenseType

	init(date: String, value: Int, currencyType: CurrencyType, operationType: OperationType, expenseType: ExpenseType) {
		self.date = date
		self.expenseText = Self.makeExpenseText(value, operationType: operationType)
		self.currencyType = currencyType
		self.expenseColor = Self.makeExpenseColor(operationType, currencyType: currencyType)
		self.expenseType = expenseType
	}

	init(object: ExpenseTransition) {
		self.date = ExpenseDateFormatter.convert(object.date)
		self.expenseText = Self.makeExpenseText(object.value, operationType: object.operationType)
		self.currencyType = object.currencyType
		self.expenseColor = Self.makeExpenseColor(object.operationType, currencyType: object.currencyType)
		self.expenseType = object.expenseType ?? .other
	}

	private static func makeExpenseText(_ expense: Int?, operationType: OperationType?) -> String {
		guard let operationType = operationType,
			  let expense = expense else { return "" }
		switch operationType {
		case .plus: return "+\(expense)"
		case .minus: return "-\(expense)"
		}
	}

	private static func makeExpenseColor(_ operationType: OperationType?, currencyType: CurrencyType) -> UIColor? {
		let loginedScreenType = LoginedScreenType(currencyType)
		switch operationType {
		case .plus: return ColorSet.BankViewColor(.logined(loginedScreenType)).expenseLabelColor
		case .minus: return ColorSet.BankViewColor(.logined(loginedScreenType)).incomeLabelColor
		case .none: return .black
		}
	}
}

private extension LoginedScreenType {
	init(_ currencyType: CurrencyType) {
		switch currencyType {
		case .poki: self = .poki
		case .miles: self = .miles
		case .bells: self = .bells
		case .loan: self = .loan
		}
	}
}
