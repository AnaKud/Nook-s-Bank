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
        let router = LoginRouter()
        let presenter = LoginPresenter(fireBaseManager: fireBaseManager, router: router, keychainService: keychainService)
        fireBaseManager.loginPresenter = presenter
        let controller = LoginViewController(presenter: presenter)
        controller.screenType = presenter.screenType
        router.controller = controller
        return controller
    }
}
