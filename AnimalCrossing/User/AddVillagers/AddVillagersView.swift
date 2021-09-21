//
//  AddVillagersView.swift
//  Created by Anastasiya Kudasheva on 18.09.2021

import UIKit

class AddVillagersView: UIView {
	lazy var colors = ColorSet(for: .other)

	var searchBar = UISearchBar()
	var villagersTable = UITableView()

	override init(frame: CGRect) {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension AddVillagersView {
	private func loadUI() {
		self.setupSearchBar()
	}

	private func setupSearchBar() {
		self.addSubview(searchBar)
		self.searchBar.snp.makeConstraints { make in
			make.top.leading.trailing.equalTo(self)
			make.height.equalTo(AppContraints.doubleEdge)
		}
		self.searchBar.delegate = self
		//self.searchBar.backgroundColor = self.colors.mainViewColor.backgroundColor
		searchBar.backgroundImage = UIImage()
		self.searchBar.barTintColor = self.colors.mainViewColor.backgroundColor
		self.searchBar.searchTextField.backgroundColor = self.colors.textfieldColor.backgroundColor
		self.searchBar.searchTextField.textColor =  self.colors.textfieldColor.textColor
		self.searchBar.searchTextField.font = ACFont.defaultLightFont.font
	}
	
}

extension AddVillagersView: UISearchBarDelegate {
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		guard let searchString = searchBar.text else { return }
		let complete = VillagerNamesAutoComplete(request: searchString)
		complete.getAnswer()
		print(searchString)
		let network = NetworkManager.shared
		network.searchVillagers(with: searchString) { stingArray in
			print(stingArray)
		}
	}
}

extension AddVillagersView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}
