// AddVillagerPresenter.swift
// Created by Anastasiya Kudasheva on 15.10.2021

class AddVillagerPresenter {
	private let router: IAddVillagerRouter
	private var addVillagerUI: AddVillagersViewController?
	private var villagersArray = [VillagerCSVDto]()
	private var autoComplete = VillagersAutoComplete()

	init(router: IAddVillagerRouter) {
		self.router = router
	}

	func didLoadUI(addVillagerUI: AddVillagersViewController) {
		self.addVillagerUI = addVillagerUI
	}

	func initialTableData() {
		self.villagersArray = self.autoComplete.getAll()
		self.addVillagerUI?.reloadData()
	}

	func searchVillager(by searchString: String) {
		self.villagersArray = self.autoComplete.getResult(for: searchString)
		self.addVillagerUI?.reloadData()
	}

	func cellItem(for index: Int) -> VillagerViewModel? {
		guard index <= (self.villagersArray.count - 1) else { return nil }
		let item = VillagerViewModel(from: self.villagersArray[index])
		return item
	}

	func cellCount() -> Int {
		print(self.villagersArray.count)
		return self.villagersArray.count
	}

	func selectItem(_ index: Int) {
		let item = VillagerViewModel(from: self.villagersArray[index])
		self.router.navigate(with: item)
	}
}
