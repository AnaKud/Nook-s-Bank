//
//  NewsAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import UIKit

class NewsAssembly {
    func build(userStatus: UserStatus, title: String) -> NewsViewController {
        let networkManager: INewsNetworkManager = NetworkManager.shared
        let coreData: INewsCoreDataManager = CoreDataManager.shared
        var router: INewsRouter = NewsRouter()
        let presenter: INewsPresenter = NewsPresenter(networkManager: networkManager, coreData: coreData, router: router)
        let controller = NewsViewController(presenter: presenter)
        controller.userStatus = userStatus
        controller.controllerTitle = AppTitle.News.controllerTitle
        
        router.controller = controller
        return controller
    }
}
