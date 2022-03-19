// BankViewModel.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

class BankViewModel {
	let loan: LoanViewModel?
	let poki: CurrencyViewModel?
	let bells: CurrencyViewModel?
	let miles: CurrencyViewModel?

	init(object: BankAccountTransition?) {
		self.loan = LoanViewModel(object: object?.loan)
		self.poki = CurrencyViewModel(object: object?.poki)
		self.bells = CurrencyViewModel(object: object?.bells)
		self.miles = CurrencyViewModel(object: object?.miles)
	}
}
