// UserSettingsAssemly.swift
// Created by Anastasiya Kudasheva on 22.07.2021.

import UIKit

enum UserSettingsAssemly {
	static func build() -> UserSettingsViewController {
		let fireBaseManager: IUserSettingsFireBaseManager = FireBaseManager.shared
		let worker = UserSettingsWorker(fireBaseManager: fireBaseManager)
		let router = UserSettingsRouter()
		var presenter: IUserSettingsPresenter = UserSettingsPresenter(router: router)
		let interactor: IUserSettingsInteractor = UserSettingsInteractor(presenter: presenter, worker: worker)
		let viewController = UserSettingsViewController(interactor: interactor)
		viewController.setupHeader("User Settings")
		router.viewController = viewController
		presenter.viewController = viewController
		return viewController
	}
}
