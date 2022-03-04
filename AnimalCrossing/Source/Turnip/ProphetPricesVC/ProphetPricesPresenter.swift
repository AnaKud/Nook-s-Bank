//
//  ProphetPricesPresenter.swift
//  Created by Anastasiya Kudasheva on 08.07.2021.

import UIKit

protocol IProphetPricesPresenter {
	var viewController: IProphetPricesViewController? { get set }
	var viewModel: ProphetPrices.Turnip.ViewModel? { get set }
	func presentSomething(response: ProphetPrices.Turnip.Response?)
}

class ProphetPricesPresenter: IProphetPricesPresenter {
	weak var viewController: IProphetPricesViewController?
	var viewModel: ProphetPrices.Turnip.ViewModel?

	func presentSomething(response: ProphetPrices.Turnip.Response?) {
		let dates = ProphetPrices.Turnip.ViewModel.Dates()

		guard let response = response,
			  response.minWeekValue != 0
		else {
			self.viewController?.displayEmptyScreen()
			return
		}
		let prices = ProphetPrices.Turnip.ViewModel.Prices(from: response)
		let minMaxPice = ProphetPrices.Turnip.ViewModel.PriceForGraph(prices: prices)
		self.viewController?.displayDateViews(dates: dates)
		self.viewController?.displayPrices(prices: prices)
		self.viewController?.displayGraph(with: minMaxPice)
		self.viewController?.displayAll()
	}
}
