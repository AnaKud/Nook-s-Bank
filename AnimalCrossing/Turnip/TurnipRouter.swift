//
//  TurnipRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 08.07.2021.
//

import UIKit

protocol ITurnipRouter {
    var controller: TurnipViewController? { get set }
    func routeToProphetPricesVC(with prices: TurnipPrices)
}

class TurnipRouter: ITurnipRouter {
    weak var controller: TurnipViewController?
    func routeToProphetPricesVC(with prices: TurnipPrices) {
        let nextVC = ProphetPricesAssembly().build(with: prices)
        print(prices.buyPrice)
        print(prices.fridayEvening)
        self.controller?.present(nextVC, animated: true)
    }
}
