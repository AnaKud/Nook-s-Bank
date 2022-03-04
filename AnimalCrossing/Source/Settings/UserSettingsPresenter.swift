// UserSettingsPresenter.swift
// Created by Anastasiya Kudasheva on 22.07.2021.

import Foundation

protocol IUserSettingsPresenter {
	var viewController: IUserSettingsViewController? { get set }
	func addVillagerButtonTapped()
}

class UserSettingsPresenter: IUserSettingsPresenter {
	private var villagersArray = [VillagerViewModel]()

	weak var viewController: IUserSettingsViewController?
	var router: UserSettingsRouter

	init(router: UserSettingsRouter) {
		self.router = router
	}

	func setNewArray() {
		print(self.villagersArray.count)
		self.viewController?.setVillagersArray(self.villagersArray)
	}

	func addVillagerButtonTapped() {
		let handler: ((VillagerViewModel) -> Void) = { villager in
			self.villagersArray.append(villager)
			self.setNewArray()
		}
		self.router.goToAddVillagerController(handler: handler)
	}
}
