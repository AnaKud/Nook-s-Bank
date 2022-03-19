// ExpenseTransition.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

class ExpenseTransition {
	var uid: String?
	var date: Double?
	var value: Int?
	var operationType: OperationType
	var expenseType: ExpenseType

	init(value: Int, operationType: OperationType, expenseType: ExpenseType) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.operationType = operationType
		self.expenseType = expenseType
	}

	init(value: Int, operationName: String, expenseName: String) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.operationType = OperationType(operationName)
		self.expenseType = ExpenseType(expenseName)
	}

	init(_ dto: ExpenseDto?) {
		self.uid = dto?.uid
		self.date = Double(dto?.date ?? Int(Date().timeIntervalSince1970))
		self.value = dto?.value
		self.operationType = OperationType(dto?.operationType)
		self.expenseType = ExpenseType(dto?.expenseType)
	}
}
