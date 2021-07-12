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
        var presenter: IBankPresenter = BankPresenter(fireBaseManager: fireBaseManager)
        presenter.screenType = screenType
        fireBaseManager.bankPresenter = presenter
        let controller = BankViewController(presenter: presenter)
        controller.screenType = screenType
        controller.controllerTitle = AppTitle.Bank.controllerTitle
        return controller
    }
}
