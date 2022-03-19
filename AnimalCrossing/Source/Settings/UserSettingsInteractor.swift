// UserSettingsInteractor.swift
// Created by Anastasiya Kudasheva on 22.07.2021.

import Foundation

protocol IUserSettingsInteractor {
	func addVillagerButtonTapped()
}

class UserSettingsInteractor {
	var presenter: IUserSettingsPresenter
	var worker: UserSettingsWorker

	init(presenter: IUserSettingsPresenter, worker: UserSettingsWorker) {
		self.presenter = presenter
		self.worker = worker
	}

	func addVillagerButtonTapped() {
		self.presenter.addVillagerButtonTapped()
	}
}

extension UserSettingsInteractor: IUserSettingsInteractor { }
