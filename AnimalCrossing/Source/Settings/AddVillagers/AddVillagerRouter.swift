//
//  AddVillagerRouter.swift
//  Created by Anastasiya Kudasheva on 08.12.2021

import UIKit

protocol IAddVillagerRouter {
	func navigate(with result: VillagerViewModel)
}

class AddVillagerRouter {
	private var villagerHandler: ((VillagerViewModel) -> Void)
	private var controller: UIViewController?

	init(villagerHandler: @escaping ((VillagerViewModel) -> Void),
		 controller: UIViewController?) {
		self.villagerHandler = villagerHandler
		self.controller = controller
	}
}

extension AddVillagerRouter: IAddVillagerRouter{
	func navigate(with result: VillagerViewModel) {
		self.villagerHandler(result)
		self.controller?.navigationController?.popViewController(animated: true)
	}
}
