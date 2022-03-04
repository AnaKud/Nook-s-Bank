//
//  UserSettingsRouter.swift
//  Created by Anastasiya Kudasheva on 08.12.2021

class UserSettingsRouter {
	weak var viewController: UserSettingsViewController?

	func goToAddVillagerController(handler: @escaping (VillagerViewModel) -> Void) {
		let nextVc = AddVillagersAssembly(villagerHandler: handler).build(from: self.viewController)
		self.viewController?.navigationController?
			.pushViewController(nextVc, animated: true)
	}

	func goBack() {
		self.viewController?.navigationController?.dismiss(animated: true)
	}
}
