// CurrencyDto.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Firebase

struct CurrencyDto {
	var account: Int?
	let type: String?
	var expenses: [ExpenseDto]?

	init(snapshot: DataSnapshot) {
		let dictionary = snapshot.value as? [String: AnyObject]
		let account = dictionary?["account"] as? Int
		let type = dictionary?["type"] as? String
		let expensesDictionary = dictionary?["expenses"] as? [String: AnyObject]
		let expenses: [ExpenseDto] = expensesDictionary?.compactMap({ dataSnap, value in
			print(value)
			return ExpenseDto(value)
		}) ?? [ExpenseDto]()
		self.init(account: account, type: type, expenses: expenses)
	}

	init(account: Int?, type: String?, expenses: [ExpenseDto]?) {
		self.account = account
		self.type = type
		self.expenses = expenses
	}
}

extension CurrencyDto: Equatable {
	static func == (lhs: CurrencyDto, rhs: CurrencyDto) -> Bool {
		return lhs.expenses == rhs.expenses
		&& lhs.account == rhs.account
		&& lhs.type == rhs.type
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

	func makeDictionary() -> [NSString: Any?] {
		[
			FirKeys.account.key: self.account,
			FirKeys.type.key: self.type,
			FirKeys.expenses.key: self.makeExpensesArray()
		]
	}

	private func makeExpensesArray() -> [[NSString: Any?]] {
		let result: [[NSString: Any?]] = self.expenses?.compactMap{
			$0.makeDictionary()
		} ?? [[NSString: Any?]]()
		return result
	}
}

extension CurrencyDto {
	init(object: CurrencyTransition?) {
		self.account = object?.account
		self.type = object?.type.name
		self.expenses = object?.expenses.compactMap {
			ExpenseDto(from: $0)
		}
	}
}
