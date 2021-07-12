//
//  TurnipAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import Foundation

class TurnipAssembly {
    func build(screenType: ScreenTypes) -> TurnipViewController {
        let firebaseManager: ITurnipFireBaseManager = FireBaseManager.shared
        let coreDataManger: ITurnipCoreDataManager = CoreDataManager.shared
        var router: ITurnipRouter = TurnipRouter()
        
        var presenter: ITurnipPresenter = TurnipPresenter(firebaseManager: firebaseManager, coreDataManger: coreDataManger, router: router)
        presenter.screenType = screenType
        let controller = TurnipViewController(presenter: presenter)
        controller.screenType = screenType
        controller.controllerTitle = AppTitle.Turnip.controllerTitle
        router.controller = controller
        return controller
    }
}
