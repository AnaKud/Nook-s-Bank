//
//  AddVillagerPresenter.swift
//  Created by Anastasiya Kudasheva on 15.10.2021

class AddVillagerPresenter {
	var answerArray = [String]()

	let autocompl = VillagerNamesAutoComplete()

	func searchVillager(by searchString: String) {
		print(#function)
		let network = NetworkManager.shared
		answerArray = autocompl.getAnswer(request: searchString)
		answerArray.forEach {
			network.searchVillagers(with: $0) { villagerArray in
				//print(villagerArray)
			}
		}
	}
	
	func cellItem(for index: Int) -> String? {
		print(#function)
		guard index <= (self.answerArray.count - 1) else { return nil }
		return self.answerArray[index]
	}
	
	func cellCount() -> Int {
		print(#function)
		return self.answerArray.count
	}
}
