//
//  BankRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 22.07.2021.
//

import Foundation

protocol IBankRouter {
	var controller: BankViewController? { get set }
	func popToViewController()
}

class BankRouter: IBankRouter {
	weak var controller: BankViewController?
	func popToViewController() {
		self.controller?.navigationController?.popToRootViewController(animated: true)
	}
}
