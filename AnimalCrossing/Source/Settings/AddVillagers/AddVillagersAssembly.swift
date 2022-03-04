//
//  AddVillagersAssembly.swift
//  Created by Anastasiya Kudasheva on 08.12.2021

import UIKit

class AddVillagersAssembly {
	private var villagerHandler: ((VillagerViewModel) -> Void)

	init(villagerHandler: @escaping ((VillagerViewModel) -> Void)) {
		self.villagerHandler = villagerHandler
	}

	func build(from controller: UIViewController?) -> AddVillagersViewController {
		let router = AddVillagerRouter(villagerHandler: self.villagerHandler,
									   controller: controller)
		let presenter = AddVillagerPresenter(router: router)
		return AddVillagersViewController(presenter: presenter)
	}
}
