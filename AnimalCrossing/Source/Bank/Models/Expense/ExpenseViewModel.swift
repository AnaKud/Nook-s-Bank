// ExpenseViewModel.swift
// Created by Anastasiya Kudasheva on 16.12.2021

import class UIKit.UIColor

class ExpenseViewModel {
	let date: String
	let expenseText: String
	let expenseColor: UIColor?
	let expenseType: String

	init(date: String, value: Int, operationType: OperationType, expenseType: ExpenseType) {
		self.date = date
		self.expenseText = Self.makeExpenseText(value, operationType: operationType)
		self.expenseColor = Self.makeExpenseColor(operationType)
		self.expenseType = expenseType.name
	}

	init(object: ExpenseTransition) {
		self.date = ExpenseDateFormatter.convert(object.date)
		self.expenseText = Self.makeExpenseText(object.value, operationType: object.operationType)
		self.expenseColor = Self.makeExpenseColor(object.operationType)
		self.expenseType = object.expenseType.name
	}

	private static func makeExpenseText(_ expense: Int?, operationType: OperationType?) -> String {
		guard let operationType = operationType,
			  let expense = expense else { return "" }
		switch operationType {
		case .plus: return "+\(expense)"
		case .minus: return "-\(expense)"
		}
	}

	private static func makeExpenseColor(_ operationType: OperationType?) -> UIColor? {
		switch operationType {
		case .plus: return ColorSet.BankViewColor(for: .loggined).expenseLabelColor
		case .minus: return ColorSet.BankViewColor(for: .loggined).incomeLabelColor
		case .none: return .black
		}
	}
}
