//
//  LoginRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import UIKit

protocol ILoginRouter {
    func goToNextWithoutLogin(withUserStatus userStatus: ScreenTypes)
    func goToNextWithLogin(withUserStatus userStatus: ScreenTypes)
}

class LoginRouter: ILoginRouter{
    weak var controller: LoginViewController?
    func goToNextWithoutLogin(withUserStatus userStatus: ScreenTypes) {
        let mainRouter = MainRouter(userStatus: userStatus)
        mainRouter.userStatus = userStatus
        let nextVC = mainRouter.returnController()
        self.controller?.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func goToNextWithLogin(withUserStatus userStatus: ScreenTypes) {
        let mainRouter = MainRouter(userStatus: userStatus)
        mainRouter.userStatus = userStatus
        let nextVC = mainRouter.returnController()
        self.controller?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
