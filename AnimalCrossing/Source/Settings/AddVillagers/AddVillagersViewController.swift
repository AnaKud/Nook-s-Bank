// AddVillagersView.swift
// Created by Anastasiya Kudasheva on 18.09.2021

import UIKit

class AddVillagersViewController: UIViewController {
	private let colors = ColorSet(for: .other)

	private let headerLabel = UILabel()
	private let searchBar = UISearchBar()
	private let villagersTable = UITableView()

	private let presenter: AddVillagerPresenter

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
		self.presenter.didLoadUI(addVillagerUI: self)
	}
}

private extension AddVillagersViewController {
	func loadUI() {
		self.setupColors()
		self.setupHeader()
		self.setupSearchBar()
		self.setupTable()
	}

	func setupColors() {
		self.view.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.villagersTable.backgroundColor = .clear
	}

	func setupHeader() {
		self.navigationItem.titleView = self.headerLabel
		self.headerLabel.textAlignment = .center
		self.headerLabel.font = ACFont.defaultBoldFont.font
		self.headerLabel.textColor = self.colors.mainViewColor.textColor
		self.headerLabel.text = "Add New Villager"
	}

	func setupSearchBar() {
		self.view.addSubview(self.searchBar)
		self.searchBar.snp.makeConstraints { make in
			make.top.equalTo(self.view).offset(AppContraints.navAndTabHeight)
			make.leading.trailing.equalTo(self.view)
			make.height.equalTo(AppContraints.doubleEdge)
		}
		self.searchBar.delegate = self
		self.searchBar.backgroundImage = UIImage()
		self.searchBar.barTintColor = self.colors.mainViewColor.backgroundColor
		self.searchBar.searchTextField.backgroundColor =
		self.colors.textfieldColor.backgroundColor
		self.searchBar.searchTextField.textColor = self.colors.textfieldColor.textColor
		self.searchBar.searchTextField.font = ACFont.defaultLightFont.font
	}
}

extension AddVillagersViewController: UISearchBarDelegate, UITextFieldDelegate {
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.searchTextField.text?.removeAll()
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
			self.villagersTable.reloadData()
		}
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchString = searchBar.text else { return }
		self.presenter.searchVillager(by: searchString)
	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		guard let searchString = searchBar.text else { return }
		self.presenter.searchVillager(by: searchString)
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		guard let searchString = searchBar.text else { return }
		self.presenter.searchVillager(by: searchString)
	}

	func reloadData() {
		self.villagersTable.reloadData()
	}
}

extension AddVillagersViewController: UITableViewDelegate, UITableViewDataSource {
	func setupTable() {
		self.villagersTable.delegate = self
		self.villagersTable.dataSource = self
		self.presenter.initialTableData()
		self.villagersTable.register(NewVillagerTableViewCell.self,
									 forCellReuseIdentifier: CellReusibleID.newVillager.rawValue)
		self.view.addSubview(self.villagersTable)
		self.villagersTable.snp.makeConstraints { make in
			make.top.equalTo(self.searchBar.snp.bottom).offset(AppContraints.doubleEdge)
			make.leading.equalTo(self.view)
			make.trailing.equalTo(self.view)
			make.bottom.equalTo(self.view).offset(-AppContraints.doubleEdge)
		}
		self.villagersTable.separatorStyle = .none
		self.villagersTable.showsVerticalScrollIndicator = false
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

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.presenter.selectItem(indexPath.row)
	}
}

extension AddVillagersViewController: INavigator {
	var currentVC: UIViewController? { return self }
}
