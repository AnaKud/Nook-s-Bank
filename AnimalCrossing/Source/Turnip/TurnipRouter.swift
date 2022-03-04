// TurnipRouter.swift
// Created by Anastasiya Kudasheva on 08.07.2021.

import UIKit

protocol ITurnipRouter {
	var controller: TurnipViewController? { get set }
	func routeToProphetPricesVC(with prices: TurnipPrices)
	func popToViewController()
}

class TurnipRouter: ITurnipRouter {
	weak var controller: TurnipViewController?
	func routeToProphetPricesVC(with prices: TurnipPrices) {
		let nextVC = ProphetPricesAssembly().build(with: prices)
		self.controller?.present(nextVC, animated: true)
	}
	func popToViewController() {
		self.controller?.navigationController?.popToRootViewController(animated: true)
	}
}
