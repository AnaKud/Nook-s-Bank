// CurrencyModel.swift
// Created by Anastasiya Kudasheva on 27.01.2022

import Firebase
import Foundation

class CurrencyViewModel {
	var account: Int
	let type: CurrencyType
	var expenses: [ExpenseViewModel]

	init(account: Int, type: CurrencyType, expenses: [ExpenseViewModel]) {
		self.account = account
		self.type = type
		self.expenses = expenses
	}
}

extension CurrencyViewModel {
	convenience init(object: CurrencyTransition?) {
		let expenses = object?.expenses.compactMap {
			ExpenseViewModel(object: $0)
		} ?? [ExpenseViewModel]()
		self.init(account: object?.account ?? 0,
				  type: object?.type ?? .bells,
				  expenses: expenses)
	}
}

class CurrencyTransition {
	let account: Int
	let type: CurrencyType
	let expenses: [ExpenseTransition]

	init(account: Int, type: CurrencyType, expenses: [ExpenseTransition]) {
		self.account = account
		self.type = type
		self.expenses = expenses
	}

	convenience init(_ dto: CurrencyDto?) {
		let expenses = dto?.expenses?.compactMap {
			print($0.makeDictionary())
			return ExpenseTransition($0)
		} ?? [ExpenseTransition]()
		self.init(account: dto?.account ?? 0,
				  type: CurrencyType(dto?.type),
				  expenses: expenses)
	}
}
