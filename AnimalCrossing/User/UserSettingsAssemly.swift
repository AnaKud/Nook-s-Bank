//
//  UserSettingsAssemly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 22.07.2021.
//

import UIKit

class UserSettingsAssemly {
    func build() -> UserSettingsViewController {
        let fireBaseManager: IUserSettingsFireBaseManager = FireBaseManager.shared
        let worker = UserSettingsWorker(fireBaseManager: fireBaseManager)
        var presenter: IUserSettingsPresenter = UserSettingsPresenter()
        let interactor: IUserSettingsInteractor = UserSettingsInteractor(presenter: presenter, worker: worker)
        let viewController = UserSettingsViewController(interactor: interactor)
		viewController.controllerTitle = "UserSettingsViewController"
        presenter.viewController = viewController
        return viewController
    }
}
