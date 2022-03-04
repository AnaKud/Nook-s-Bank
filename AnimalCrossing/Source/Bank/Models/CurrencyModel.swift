// CurrencyModel.swift
// Created by Anastasiya Kudasheva on 27.01.2022

import Foundation
import Firebase

struct CurrencyViewModel {
	var account: Int
	let type: CurrencyType
	var expenses: [ExpenseViewModel]
}

extension CurrencyViewModel {
	init?(object: CurrencyTransition?) {
		guard let account = object?.account,
			  let type = object?.type else { return nil }
		self.account = account
		self.type = type
		self.expenses = object?.expenses.compactMap {
			ExpenseViewModel(object: $0)
		} ?? [ExpenseViewModel]()
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

	init?(_ dto: CurrencyDto?) {
		guard let account = dto?.account,
			  let currencyType = dto?.type
		else { return nil }
		self.account = account
		self.type = CurrencyType(currencyType)
		self.expenses = dto?.expenses.compactMap {
			ExpenseTransition($0)
		} ?? [ExpenseTransition]()
	}
}

struct CurrencyDto: Decodable {
	var account: Int
	let type: String
	var expenses: [ExpenseDTO]

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirKeys.self)
		self.account = try container.decode(Int.self, forKey: .account)
		self.type = try container.decode(String.self, forKey: .type)
		self.expenses = try container.decode([ExpenseDTO].self, forKey: .expenses)
	}

	init(account: Int, type: String, expenses: [ExpenseDTO]) {
		self.account = account
		self.type = type
		self.expenses = expenses
	}
}

extension CurrencyDto: IFirDictionary {
	enum FirKeys: IFirKeys, CodingKey {
		case account
		case type
		case expenses

		var key: NSString {
			switch self {
			case .account: return "account"
			case .type: return "type"
			case .expenses: return "expenses"
			}
		}
	}

	func makeDictionary() -> [NSString : Any] {
		[
			FirKeys.account.key: "\(self.account)",
			FirKeys.type.key: self.type,
			FirKeys.expenses.key: self.makeExpensesArray()
		]
	}

	private func makeExpensesArray() -> [[NSString : Any]] {
		var result = [[NSString : Any]]()
		for expense in self.expenses {
			result.append(expense.makeDictionary())
		}
		return result
	}
}

extension CurrencyDto {
	init(object: CurrencyTransition) {
		self.account = object.account
		self.type = object.type.name
		self.expenses = object.expenses.compactMap {
			ExpenseDTO(from: $0)
		}
	}
}

enum CurrencyType: IFirKeys{
	case poki
	case miles
	case bells

	var key: NSString {
		switch self {
		case .poki: return "poki"
		case .miles: return "miles"
		case .bells: return "bells"
		}
	}

	var name: String {
		switch self {
		case .poki: return "poki"
		case .miles: return "miles"
		case .bells: return "bells"
		}
	}

	init(_ name: String) {
		switch name {
		case "poki": self = .poki
		case "miles": self = .miles
		default: self = .bells
		}
	}
}
