// ProphetPricesWorker.swift
// Created by Anastasiya Kudasheva on 08.07.2021.

import UIKit

class ProphetPricesWorker {
	var networkManager: IProphetPricesNetworkManager

	init(networkManager: IProphetPricesNetworkManager) {
		self.networkManager = networkManager
	}
	func doSomeWork(with data: ProphetPrices.Turnip.Request, completion: @escaping (TurnipResponse?) -> Void) {
		self.networkManager.downloadTurnip(forTurnipPrices: data) { response in
			if data.buyPrice == 0 {
				completion(nil)
			} else {
				completion(response)
			}
		}
	}
}
