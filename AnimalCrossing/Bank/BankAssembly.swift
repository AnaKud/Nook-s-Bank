//
//  BankAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import Foundation

class BankAssembly {
    func build(screenType: ScreenTypes) -> BankViewController {
        var fireBaseManager: IBankFireBaseManager = FireBaseManager.shared
        var router: IBankRouter = BankRouter()
        var presenter: IBankPresenter = BankPresenter(fireBaseManager: fireBaseManager, router: router)
        presenter.screenType = screenType
        fireBaseManager.bankPresenter = presenter
        let controller = BankViewController(presenter: presenter)
        router.controller = controller
        controller.screenType = screenType
        controller.controllerTitle = AppTitle.Bank.controllerTitle
        return controller
    }
}
