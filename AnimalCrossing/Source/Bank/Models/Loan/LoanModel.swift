// LoanModel.swift
// Created by Anastasiya Kudasheva on 27.01.2022

import Foundation

struct LoanViewModel {
	let currentValue: Int
	let loanHistory: [LoanHistoryViewModel]
}

extension LoanViewModel {
	init?(object: LoanTransition?) {
		guard let objectCurrentValue = object?.currentValue,
			  let objectLoanHistory = object?.loanHistory
		else { return nil }
		self.currentValue = objectCurrentValue
		self.loanHistory = objectLoanHistory.compactMap {
			LoanHistoryViewModel(object: $0)
		}
	}
}

class LoanTransition {
	let currentValue: Int
	let loanHistory: [LoanHistoryTransition]

	init(currentValue: Int, loanHistory: [LoanHistoryTransition]) {
		self.currentValue = currentValue
		self.loanHistory = loanHistory
	}

	init?(_ dto: LoanDto?) {
		guard let dtoCurrentValue = dto?.currentValue,
			  let dtoLoanHistory = dto?.loanHistory
		else { return nil }
		self.currentValue = dtoCurrentValue
		self.loanHistory = dtoLoanHistory.compactMap {
			LoanHistoryTransition($0)
		}
	}
}

struct LoanDto: Decodable {
	var currentValue: Int?
	let type = CurrencyType.loan
	let loanHistory: [LoanHistoryDto]?
}

extension LoanDto {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirKeys.self)
		self.currentValue = try container.decode(Int.self, forKey: .currentValue)
		self.loanHistory = try container.decode([LoanHistoryDto].self, forKey: .loanHistory)
	}
}

extension LoanDto: IFirDictionary {
	enum FirKeys: IFirKeys, CodingKey {
		case currentValue
		case loanHistory

		var key: NSString {
			switch self {
			case .currentValue: return "currentValue"
			case .loanHistory: return "loanHistory"
			}
		}
	}

	func makeDictionary() -> [NSString : Any?] {
		[
			FirKeys.currentValue.key: self.currentValue,
			FirKeys.loanHistory.key: self.makeLoanHistoryArray()
		]
	}

	private func makeLoanHistoryArray() -> [[NSString : Any?]] {
		let result: [[NSString: Any?]] = self.loanHistory?.compactMap {
			$0.makeDictionary()
		} ?? [[NSString: Any?]]()
		return result
	}
}

extension LoanDto {
	init(object: LoanTransition?) {
		self.currentValue = object?.currentValue
		self.loanHistory = object?.loanHistory.compactMap {
			LoanHistoryDto(object: $0)
		}
	}
}
