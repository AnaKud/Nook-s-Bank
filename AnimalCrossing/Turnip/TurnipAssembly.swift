//
//  TurnipAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import Foundation

class TurnipAssembly {
    func build(userStatus: ScreenTypes) -> TurnipViewController {
        let networkManager: ITurnipNetworkManager = NetworkManager.shared
        let coreDataManger: ITurnipCoreDataManager = CoreDataManager.shared
        
        let presenter: ITurnipPresenter = TurnipPresenter(networkManager: networkManager, coreDataManger: coreDataManger)
        
        let controller = TurnipViewController(presenter: presenter)
        controller.userStatus = userStatus
        controller.controllerTitle = AppTitle.Turnip.controllerTitle
        return controller
    }
}
