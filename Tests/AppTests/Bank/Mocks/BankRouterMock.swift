// BankRouterMock.swift
// Created by Anastasiya Kudasheva on 04.03.2022

@testable import AnimalCrossing

class BankRouterMock: IBankRouter {
	var state: String = ""
	var controller: BankViewController?
	func popToViewController() {
		self.state = "popToViewController"
	}
}
