//
//  NewsAssembly.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import UIKit

class NewsAssembly {
    func build(userStatus: UserStatus, title: String) -> NewsViewController {
        let networkManager: INewsNetworkManager = NetworkManager()
        let coreData: INewsCoreDataManager = CoreDataManager()
        let presenter: INewsPresenter = NewsPresenter(networkManager: networkManager, coreData: coreData)
        let controller = NewsViewController(presenter: presenter)
        controller.userStatus = userStatus
        controller.controllerTitle = "Nook News"
        return controller
    }
    
}
