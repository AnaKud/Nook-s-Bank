// RegisterUserAssemly.swift
// Created by Anastasiya Kudasheva on 22.07.2021.

import UIKit

enum RegisterUserAssemly {
	static func build() -> RegisterUserViewController {
		let fireBaseManager: IUserFBRegistration = FireBaseManager.shared
		let worker = RegisterUserWorker(fireBaseManager: fireBaseManager, userValidator: NewUserValidator())
		let router = RegisterUserRouter()
		let presenter: IRegisterUserPresenter = RegisterUserPresenter()
		let interactor: IRegisterUserInteractor = RegisterUserInteractor(presenter: presenter, worker: worker, router: router)
		let viewController = RegisterUserViewController(interactor: interactor)
		return viewController
	}
}
