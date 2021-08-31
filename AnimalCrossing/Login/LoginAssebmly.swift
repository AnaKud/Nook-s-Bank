//
//  LoginAssebmly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import UIKit

final class LoginAssebmly {
    func build() -> LoginViewController {
        var fireBaseManager: ILoginFireBaseManager = FireBaseManager.shared
        let keychainService: IKeychainService = KeychainService.shared
        let authenticationService: IDeviceOwnerAuthentication = DeviceOwnerAuthentication.shared
		let worker = LoginWorker(fireBaseManager: fireBaseManager,
								 keychainService: keychainService,
								 authenticationService: authenticationService)
        let router = LoginRouter()
		let presenter: ILoginPresenter = LoginPresenter()

		let interactor: ILoginInteractor = LoginInteractor(presenter: presenter,
														  worker: worker,
														  router: router)
        let controller = LoginViewController(interactor: interactor)
// check for firebase
		fireBaseManager.loginPresenter = presenter
		presenter.viewController = controller
        router.controller = controller
        return controller
    }
}
