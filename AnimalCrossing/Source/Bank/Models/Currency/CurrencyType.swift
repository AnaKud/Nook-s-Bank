// CurrencyType.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

enum CurrencyType: IFirKeys {
	case poki
	case miles
	case bells
	case loan

	init(_ name: String?) {
		switch name {
		case "poki": self = .poki
		case "miles": self = .miles
		case "loan": self = .loan
		default: self = .bells
		}
	}

	init(_ screenType: LoginedScreenType) {
		switch screenType {
		case .poki: self = .poki
		case .miles: self = .miles
		case .bells, .main: self = .bells
		case .loan: self = .loan
		}
	}

	var key: NSString {
		switch self {
		case .poki: return "poki"
		case .miles: return "miles"
		case .bells: return "bells"
		case .loan: return "loan"
		}
	}

	var name: String {
		switch self {
		case .poki: return "poki"
		case .miles: return "miles"
		case .bells: return "bells"
		case .loan: return "loan"
		}
	}

	func expeses(_ operationType: OperationType) -> [ExpenseType] {
		switch (self, operationType) {
		case (.poki, .plus): return self.incomeForPoki()
		case (.poki, .minus): return self.expenseForPoki()
		case (.miles, .plus): return self.incomeForMiles()
		case (.miles, .minus): return self.expenseForMiles()
		case (.bells, .plus),
			(.bells, .minus): return self.expenseAndIncomeForBells()
		case (.loan, .plus),
			(.loan, .minus): return self.expenseAndIncomeForLoan()
		}
	}
}

private extension CurrencyType {
	func incomeForPoki() -> [ExpenseType] {
		return [.work]
	}

	func expenseForPoki() -> [ExpenseType] {
		return [.furniture, .clothing, .tools, .other]
	}
	
	func incomeForMiles() -> [ExpenseType] {
		return [
			.furniture,
			.clothing,
			.tools,
			.music,
			.garden,
			.other
		]
	}

	func expenseForMiles() -> [ExpenseType] {
		return [.cashback, .other]
	}
	
	func expenseAndIncomeForBells() -> [ExpenseType] {
		return [
			.furniture,
			.clothing,
			.bugs,
			.fish,
			.seaCreatures,
			.tools,
			.fossils,
			.artwork,
			.music,
			.garden,
			.turnip,
			.other
		]
	}

	func expenseAndIncomeForLoan() -> [ExpenseType] {
		return [.other]
	}
}
