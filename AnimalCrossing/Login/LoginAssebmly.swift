//
//  LoginAssebmly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import UIKit

final class LoginAssebmly {
    func build() -> UIViewController {
        let fireBaseManager: ILoginFireBaseManager = FireBaseManager()
        let networkManager: ILoginNetworkManager = NetworkManager()
        let coreDataStorage: ILoginCoreDataManager = CoreDataManager()
        let router = LoginRouter()
        let presenter = LoginPresenter(fireBaseManager: fireBaseManager, networkManager: networkManager, coreDataManager: coreDataStorage, router: router)
        
        let controller = LoginViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
