// BankAccountDto.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import Firebase
import Foundation

class BankAccountDto {
	var bells: CurrencyDto?

	init(bells: CurrencyDto?) {
		self.bells = bells
	}
}

extension BankAccountDto: Equatable {
	static func == (lhs: BankAccountDto, rhs: BankAccountDto) -> Bool {
		lhs.bells == rhs.bells
	}
}

extension BankAccountDto {
	convenience init(snapshot: DataSnapshot) {
		self.init(bells: CurrencyDto(
			snapshot: snapshot.childSnapshot(forPath: FirKeys.bells.stringValue)
		))
	}
}

extension BankAccountDto {
	convenience init(object: BankAccountTransition) {
		self.init(bells: CurrencyDto(object: object.bells))
	}
}

extension BankAccountDto: IFirDictionary {
	enum FirKeys: IFirKeys, CodingKey {
		case loan
		case poki
		case bells
		case miles

		var key: NSString {
			switch self {
			case .loan: return "loan"
			case .poki: return "poki"
			case .bells: return "bells"
			case .miles: return "miles"
			}
		}
	}

	func makeDictionary() -> [NSString: Any?] {
		[
			FirKeys.bells.key: self.bells?.makeDictionary()
		]
	}
}
