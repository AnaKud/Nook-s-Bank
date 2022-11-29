// ExpenseTransition.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

class ExpenseTransition {
	var uid: String?
	var date: Double?
	var value: Int?
	var currencyType: CurrencyType
	var operationType: OperationType
	var expenseType: ExpenseType?

	init(value: Int?, currencyType: CurrencyType, operationType: OperationType, expenseType: ExpenseType?) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.currencyType = currencyType
		self.operationType = operationType
		self.expenseType = expenseType
	}

	init(value: Int, currencyType: CurrencyType, operationName: String, expenseName: String) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.currencyType = currencyType
		self.operationType = OperationType(operationName)
		self.expenseType = ExpenseType(expenseName)
	}

	init(_ dto: ExpenseDto?) {
		self.uid = dto?.uid
		self.date = Double(dto?.date ?? Int(Date().timeIntervalSince1970))
		self.value = dto?.value
		self.currencyType = CurrencyType(dto?.currencyType)
		self.operationType = OperationType(dto?.operationType)
		self.expenseType = ExpenseType(dto?.expenseType)
	}
}

extension ExpenseTransition: Equatable {
	static func == (lhs: ExpenseTransition, rhs: ExpenseTransition) -> Bool {
		return lhs.uid == rhs.uid
		&& lhs.date == rhs.date
		&& lhs.value == rhs.value
		&& lhs.currencyType.name == rhs.currencyType.name
		&& lhs.operationType.name == rhs.operationType.name
		&& lhs.expenseType?.name == rhs.expenseType?.name
	}
}
