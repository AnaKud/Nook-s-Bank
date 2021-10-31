//
//  AddVillagersView.swift
//  Created by Anastasiya Kudasheva on 18.09.2021

import UIKit

class AddVillagersViewController: UIViewController {
	var searchTResult = [String]()

	lazy var colors = ColorSet(for: .other)

	var searchBar = UISearchBar()
	var villagersTable = UITableView()

	var presenter: AddVillagerPresenter
	init(presenter: AddVillagerPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadUI()
	}
}

private extension AddVillagersViewController {
	func loadUI() {
		self.stupColors()
		
		self.setupSearchBar()
		self.setupTable()
	}

	func stupColors() {
		self.view.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.villagersTable.backgroundColor = .clear
	}

	func setupSearchBar() {
		self.view.addSubview(searchBar)
		self.searchBar.snp.makeConstraints { make in
			make.top.equalTo(self.view).offset(AppContraints.navAndTabHeight)
			make.leading.trailing.equalTo(self.view)
			make.height.equalTo(AppContraints.doubleEdge)
		}
		self.searchBar.delegate = self
		searchBar.backgroundImage = UIImage()
		self.searchBar.barTintColor = self.colors.mainViewColor.backgroundColor
		self.searchBar.searchTextField.backgroundColor =
			self.colors.textfieldColor.backgroundColor
		self.searchBar.searchTextField.textColor = self.colors.textfieldColor.textColor
		self.searchBar.searchTextField.font = ACFont.defaultLightFont.font
	}
}

extension AddVillagersViewController: UISearchBarDelegate, UITextFieldDelegate {
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		guard let searchString = searchBar.text else { return }
		print("searchString \(searchString)")
		self.presenter.searchVillager(by: searchString)
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
		self.villagersTable.reloadData()
		}
	}
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		switch reason {
		case .committed:
			print("vvv")
		@unknown default:
			print("vvfffv")
		}
	}
}

extension AddVillagersViewController: UITableViewDelegate, UITableViewDataSource {
	func setupTable() {
		self.villagersTable.delegate = self
		self.villagersTable.dataSource = self
		self.villagersTable.register(NewVillagerTableViewCell.self,
									 forCellReuseIdentifier: CellReusibleID.newVillager.rawValue)
		self.view.addSubview(self.villagersTable)
		self.villagersTable.snp.makeConstraints { make in
			make.top.equalTo(self.searchBar.snp.bottom).offset(AppContraints.doubleEdge)
			make.leading.equalTo(self.view).offset(AppContraints.doubleEdge)
			make.trailing.bottom.equalTo(self.view).offset(-AppContraints.doubleEdge)
		}
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter.cellCount()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReusibleID.newVillager.rawValue,
													   for: indexPath) as? NewVillagerTableViewCell,
			  let item = self.presenter.cellItem(for: indexPath.row)
		else { return UITableViewCell() }
		cell.config(with: item)
		return cell
	}
}
