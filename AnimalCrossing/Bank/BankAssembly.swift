//
//  BankAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import Foundation

class BankAssembly {
    func build(userStatus: ScreenTypes) -> BankViewController {
        var fireBaseManager: IBankFireBaseManager = FireBaseManager.shared
        var presenter: IBankPresenter = BankPresenter(fireBaseManager: fireBaseManager)
        presenter.userStatus = userStatus
        fireBaseManager.bankPresenter = presenter
        let controller = BankViewController(presenter: presenter)
        controller.userStatus = userStatus
        controller.controllerTitle = AppTitle.Bank.controllerTitle
        return controller
    }
}
