// BankPresenter.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import Foundation

protocol IBankPresenter {
	func loadVC(_ view: IBankViewController)
	func showAccountValue(_ value: String)
	func refreshCollectionView()
	func showAddExpenseAlert()
	func showErrorAlert(error: ACError, handler: (() -> Void)?)
}

class BankPresenter {
	private var viewController: IBankViewController?

	init() { }
}

extension BankPresenter: IBankPresenter {
	func loadVC(_ vc: IBankViewController) {
		self.viewController = vc
		self.viewController?.interfaceWithData()
	}

	func showAccountValue(_ value: String) {
		self.viewController?.setNewTotalAccountValue(value)
	}

	func refreshCollectionView() {
		self.viewController?.refreshCollectionView()
	}

	func showAddExpenseAlert() {
		self.viewController?.showAddExpenseAlert()
	}

	func showErrorAlert(error: ACError, handler: (() -> Void)?) {
		self.viewController?.showErrorAlert(title: error.humanfriendlyTitle,
											message: error.humanfriendlyMessage,
											handler: handler)
	}
}
