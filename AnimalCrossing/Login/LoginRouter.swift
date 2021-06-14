//
//  LoginRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import UIKit

protocol ILoginRouter {
    func goToNextWithoutLogin(withUserStatus userStatus: UserStatus, withTitle title: String)
    func goToNextWithLogin(withUserStatus userStatus: UserStatus, withTitle title: String)
}

class LoginRouter: ILoginRouter{
    weak var controller: LoginViewController?
    func goToNextWithoutLogin(withUserStatus userStatus: UserStatus, withTitle title: String) {
        let mainRouter = MainRouter(userStatus: userStatus, title: title)
        mainRouter.userStatus = userStatus
        mainRouter.title = title
        let nextVC = mainRouter.returnController()
        self.controller?.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func goToNextWithLogin(withUserStatus userStatus: UserStatus, withTitle title: String) {
        let mainRouter = MainRouter(userStatus: userStatus, title: title)
        mainRouter.userStatus = userStatus
        mainRouter.title = title
        let nextVC = mainRouter.returnController()
        self.controller?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
