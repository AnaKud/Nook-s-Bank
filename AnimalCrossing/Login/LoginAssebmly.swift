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
        let router = LoginRouter()
        let presenter = LoginPresenter(fireBaseManager: fireBaseManager, router: router)
        fireBaseManager.loginPresenter = presenter
        let controller = LoginViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
