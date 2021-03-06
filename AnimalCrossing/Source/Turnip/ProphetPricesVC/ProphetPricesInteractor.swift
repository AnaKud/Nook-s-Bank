// ProphetPricesInteractor.swift
// Created by Anastasiya Kudasheva on 08.07.2021.

import UIKit

typealias IProphetPricesInteractor = IProphetPricesInteractorBusinessLogic & IProphetPricesDataStore

protocol IProphetPricesInteractorBusinessLogic {
	func makeTurnipPricesRequest()
}

protocol IProphetPricesDataStore {
	var dataForRequest: TurnipPrices? { get set }
}

class ProphetPricesInteractor: IProphetPricesInteractor {
	var dataForRequest: TurnipPrices?

	var presenter: IProphetPricesPresenter
	var worker: ProphetPricesWorker

	init(presenter: IProphetPricesPresenter, worker: ProphetPricesWorker) {
		self.presenter = presenter
		self.worker = worker
	}

	func makeTurnipPricesRequest() {
		let request = ProphetPrices.Turnip.Request(from: dataForRequest)
		worker.doSomeWork(with: request) { [ weak self ] result in
			let existingPrices = request.pricesArray()
			let response = ProphetPrices.Turnip.Response(from: result, existingPrices: existingPrices)

			self?.presenter.presentSomething(response: response)
		}
	}
}
