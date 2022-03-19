//
//  BankRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 22.07.2021.
//

import Foundation

protocol IBankRouter {
	func loadNavigator(_ navigator: INavigator)
	func popToViewController()
}

class BankRouter: IBankRouter {
	private weak var navigator: INavigator?

	func loadNavigator(_ navigator: INavigator) {
		self.navigator = navigator
	}

	func popToViewController() {
		self.navigator?.popToRootVC(animated: true)
	}
}
