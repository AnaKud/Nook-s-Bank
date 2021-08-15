//
//  LoginRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import UIKit

protocol ILoginRouter {
    func goToNextWithoutLogin(withScreenType screenType: ScreenTypes)
    func goToNextWithLogin(withScreenType screenType: ScreenTypes)
    func reloadLoginView(withScreenType screenType: ScreenTypes) 
}

class LoginRouter: ILoginRouter{
    weak var controller: LoginViewController?
    func goToNextWithoutLogin(withScreenType screenType: ScreenTypes) {
        let mainRouter = MainRouter(screenType: screenType)
        mainRouter.screenType = screenType
        let nextVC = mainRouter.returnController()
        self.controller?.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func goToNextWithLogin(withScreenType screenType: ScreenTypes) {
        let mainRouter = MainRouter(screenType: screenType)
        mainRouter.screenType = screenType
        let nextVC = mainRouter.returnController()
        self.controller?.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func reloadLoginView(withScreenType screenType: ScreenTypes) {
        let nextVC = LoginAssebmly().build()
        self.controller?.navigationController?.pushViewController(nextVC, animated: false)

    }
}
