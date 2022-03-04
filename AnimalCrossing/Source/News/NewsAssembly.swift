// NewsAssembly.swift
// Created by Anastasiya Kudasheva on 11.06.2021.

import UIKit

class NewsAssembly {
	func build(screenType: ScreenTypes) -> NewsViewController {
		let networkManager: INewsNetworkManager = NetworkManager.shared
		let coreData: INewsCoreDataManager = CoreDataManager.shared
		let router: INewsRouter = NewsRouter()
		let worker = NewsWorker(networkManager: networkManager, coreData: coreData)
		let presenter: INewsPresenter = NewsPresenter()
		let interactor: INewsInteractor = NewsInteractor(worker: worker,
														 router: router,
														 presenter: presenter)
		let controller = NewsViewController(interactor: interactor)
		router.setupVC(controller)
		controller.setupScreenType(screenType)
		controller.setupControllerTitle( AppTitle.News.controllerTitle)

		return controller
	}
}
