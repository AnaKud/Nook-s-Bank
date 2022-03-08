// BankAssembly.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import Foundation

class BankAssembly {
	func build(screenType: ScreenTypes) -> BankViewController {
		var demoDataBase: IBankDataBaseManager
		switch screenType {
		case .loggined: demoDataBase = FireBaseManager.shared
		default: demoDataBase = BankDemoDataBase()
		}
		// TODO: Добавить кордату и по пинкоду давать доступ к данным
		// TODO: Сделать полноценный норм экран с добавлением расходов
		let router: IBankRouter = BankRouter()
		let presenter: IBankPresenter = BankPresenter(demoDataBase: demoDataBase, router: router)
		let controller = BankViewController(presenter: presenter, screenType: screenType)
		return controller
	}
}
