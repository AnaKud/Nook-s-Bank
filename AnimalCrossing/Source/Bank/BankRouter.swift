//
//  BankRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 22.07.2021.
//

import Foundation

protocol IBankRouter {
	func loadVC(_ vc: BankViewController)
	func popToViewController()
}

class BankRouter: IBankRouter {
	private weak var controller: BankViewController?

	func loadVC(_ vc: BankViewController) {
		self.controller = vc
	}

	func popToViewController() {
		self.controller?.navigationController?.popToRootViewController(animated: true)
	}
}
