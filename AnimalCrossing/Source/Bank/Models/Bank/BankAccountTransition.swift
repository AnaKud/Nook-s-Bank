// BankAccountTransition.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

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
		self.loan = nil // LoanTransition(dto.loan)
		self.poki = nil // CurrencyTransition(dto.poki)
		self.bells = CurrencyTransition(dto.bells)
		self.miles = nil // CurrencyTransition(dto.miles)
	}
}
