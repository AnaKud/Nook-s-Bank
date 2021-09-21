//
//  ProphetPricesWorker.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 08.07.2021.
//  Copyright (c) 2021. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

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