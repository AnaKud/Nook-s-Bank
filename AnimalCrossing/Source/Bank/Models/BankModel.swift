// BankModel.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import Firebase
import Foundation

class BankViewModel {
	let loan: LoanViewModel?
	let poki: CurrencyViewModel?
	var bells: CurrencyViewModel?
	let miles: CurrencyViewModel?

	init(object: BankAccountTransition?) {
		self.loan = LoanViewModel(object: object?.loan)
		self.poki = CurrencyViewModel(object: object?.poki)
		self.bells = CurrencyViewModel(object: object?.bells)
		self.miles = CurrencyViewModel(object: object?.miles)
	}
}

class BankAccountTransition {
	let loan: LoanTransition?
	let poki: CurrencyTransition?
	var bells: CurrencyTransition?
	let miles: CurrencyTransition?

	init(loan: LoanTransition?,
		 poki: CurrencyTransition?,
		 bells: CurrencyTransition?,
		 miles: CurrencyTransition?) {
		self.loan = loan
		self.poki = poki
		self.bells = bells
		self.miles = miles
	}

	init(_ dto: BankAccountDto) {
		self.loan = LoanTransition(dto.loan)
		self.poki = CurrencyTransition(dto.poki)
		self.bells = CurrencyTransition(dto.bells)
		self.miles = CurrencyTransition(dto.miles)
	}
}

struct BankAccountDto: Decodable {
	let loan: LoanDto?
	let poki: CurrencyDto?
	var bells: CurrencyDto?
	let miles: CurrencyDto?

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirKeys.self)
		self.loan = try container.decode(LoanDto.self, forKey: .loan)
		self.poki = try container.decode(CurrencyDto.self, forKey: .poki)
		self.bells = try container.decode(CurrencyDto.self, forKey: .bells)
		self.miles = try container.decode(CurrencyDto.self, forKey: .miles)
	}

	init(loan: LoanDto?, poki: CurrencyDto?, bells: CurrencyDto?, miles: CurrencyDto?) {
		self.loan = loan
		self.bells = bells
		self.poki = poki
		self.miles = miles
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

	func makeDictionary() -> [NSString : Any] {
		[
			FirKeys.loan.key: self.loan!.makeDictionary(),
			FirKeys.poki.key: self.poki!.makeDictionary(),
			FirKeys.bells.key: self.bells!.makeDictionary(),
			FirKeys.miles.key: self.miles!.makeDictionary()
		]
	}
}

extension BankAccountDto {
	init?(object: BankAccountTransition) {
		guard let objectLoan = object.loan,
			  let objectPoki = object.poki,
			  let objectBells = object.bells,
			  let objectMiles = object.miles
		else { return nil }
		self.loan = LoanDto(object: objectLoan)
		self.poki = CurrencyDto(object: objectPoki)
		self.bells = CurrencyDto(object: objectBells)
		self.miles = CurrencyDto(object: objectMiles)
	}
}
