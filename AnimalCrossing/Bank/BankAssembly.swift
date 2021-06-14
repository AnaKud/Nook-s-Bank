//
//  BankAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import Foundation


class BankAssembly {
    func build(userStatus: UserStatus, title: String) -> BankViewController {
        //let networkManager: INewsNetworkManager = NetworkManager()
       // let coreData: INewsCoreDataManager = CoreDataManager()
        var fireBaseManager: IBankFireBaseManager = FireBaseManager()
        var presenter: IBankPresenter = BankPresenter(fireBaseManager: fireBaseManager)
        presenter.userStatus = userStatus
        fireBaseManager.bankPresenter = presenter
        //coreData.initErrorPresenterForNews(errorPresenter: presenter)
        let controller = BankViewController(presenter: presenter)
        controller.userStatus = userStatus
        controller.controllerTitle = title
        print("ullog statt \(userStatus)")
        return controller
    }
    
}
