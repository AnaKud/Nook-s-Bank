// BankAssembly.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import Foundation

class BankAssembly {
	func build(screenType: ScreenType) -> BankViewController {
		let dataBaseManager: IBankDataBaseManager
		switch screenType {
		case .unlogined, .additionalScreen:
			dataBaseManager = BankDemoDataBase()
		case .logined:
			dataBaseManager = FireBaseManager.shared
		}
		// TODO: Добавить кордату и по пинкоду давать доступ к данным
		// TODO: Сделать полноценный норм экран с добавлением расходов
		let router: IBankRouter = BankRouter()
		let worker = BankWorker(dataBaseManager: dataBaseManager)
		let presenter = BankPresenter()
		let interactor: IBankInteractor = BankInteractor(presenter: presenter, router: router, worker: worker)
		let controller = BankViewController(interactor: interactor, screenType: screenType)
		return controller
	}
}
