//
//  LoginPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation

protocol ILoginPresenter {
    func viewDidLoad(view: LoginViewController)
}

class LoginPresenter {
    var fireBaseManager: ILoginFireBaseManager
    var networkManager: ILoginNetworkManager
    var coreDataManager: ILoginCoreDataManager
    var router: ILoginRouter
    
    var view: ILoginViewController?
    
    init(fireBaseManager: ILoginFireBaseManager, networkManager: ILoginNetworkManager, coreDataManager: ILoginCoreDataManager, router: ILoginRouter) {
        self.fireBaseManager = fireBaseManager
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
        self.router = router
        
    }
    
    
}

extension LoginPresenter: ILoginPresenter {
    func viewDidLoad(view: LoginViewController) {
        self.view = view
    }
    
    
}
