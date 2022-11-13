// BankViewControllerMock.swift
// Created by Anastasiya Kudasheva on 04.03.2022

@testable import AnimalCrossingBank
import UIKit

class BankViewControllerMock: IBankViewController {
	var currentVC: UIViewController? { return nil }

	private(set) var balanceString = ""

	init() { }

	func setNewTotalAccountValue(_ value: String) {
		self.balanceString = value
	}

	func interfaceWithData() { }

	func refreshCollectionView() { }

	func showAddExpenseAlert() { }

	func showErrorAlert(title: String?, message: String, handler: (() -> Void)?) { }
}
