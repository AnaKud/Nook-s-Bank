//
//  ProphetPricesAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 08.07.2021.
//

import UIKit

class ProphetPricesAssembly {
    func build(with prices: TurnipPrices) -> ProphetPricesViewController {
        let networkManager: IProphetPricesNetworkManager = NetworkManager.shared
        let worker = ProphetPricesWorker(networkManager: networkManager)
        var presenter: IProphetPricesPresenter = ProphetPricesPresenter()
        var interactor: IProphetPricesInteractor = ProphetPricesInteractor(presenter: presenter, worker: worker)
        interactor.dataForRequest = prices
        let viewController = ProphetPricesViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
