// NotificationSettingsView.swift
// Created by Anastasiya Kudasheva on 18.09.2021

import UIKit

protocol IUserSettingsControllerCallback {
	func addVillagerButtonTapped()
}

class NotificationSettingsView: UIView {
	var array = [VillagerViewModel]()

	lazy var colors = ColorSet(for: .other)

	var controllerCallback: IUserSettingsControllerCallback?

	var scrollView = UIScrollView()
	var contentView = UIView()

	var notificationModeTitleLabel = UILabel()
	var allNotificationModeLabel = UILabel()
	var allNotificationModeSwitch = UISwitch()
	var eventNotificationModeLabel = UILabel()
	var eventNotificationModeSwitch = UISwitch()
	var villagerBirthgayNotificationModeLabel = UILabel()
	var villagerBirthgayNotificationModeSwitch = UISwitch()
	var addVillagerTitleLabel = UILabel()
	var addVillagerButton = UIButton()
	var addVillagerTable = UITableView()
	var saveSettingsButton = UIButton()

	init() {
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func loadUI() {
		self.setupScrollView()
		self.setupNotificationTitleMode()
		self.setupNotificationModeSection()
		self.setupAddVillagerTableHeader()
		self.setupAddVillagerTable()
		self.setupSaveSettingsButton()
	}
}

private extension NotificationSettingsView {
	func setupScrollView() {
		self.addSubview(self.scrollView)
		self.scrollView.snp.makeConstraints { make in
			make.edges.equalTo(self)
		}
		self.scrollView.delegate = self
		self.scrollView.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.edges.equalTo(self.scrollView)
			make.width.equalTo(self.snp.width)
		}
		self.scrollView.alwaysBounceVertical = true
		self.scrollView.contentSize = CGSize(width: self.frame.width,
											 height: self.frame.height)
	}

	func setupNotificationTitleMode() {
		self.notificationModeTitleLabel.text = "Select notification mode"
		self.notificationModeTitleLabel.numberOfLines = 0
		self.notificationModeTitleLabel.textAlignment = .center
		self.notificationModeTitleLabel.textColor = self.colors.mainViewColor.textColor
		self.notificationModeTitleLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.notificationModeTitleLabel)
		self.notificationModeTitleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.contentView).offset(AppContraints.standartEdge)
			make.leading.trailing.equalTo(self.contentView)
		}
	}

	func setupNotificationModeSection() {
		self.allNotificationModeLabel.text = "All"
		self.allNotificationModeLabel.textColor = self.colors.mainViewColor.textColor
		self.allNotificationModeLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.allNotificationModeLabel)
		self.allNotificationModeLabel.snp.makeConstraints { make in
			make.top.equalTo(self.notificationModeTitleLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.standartEdge)
		}
		self.allNotificationModeSwitch = CustomSwitcher(color: self.colors)
		self.contentView.addSubview(self.allNotificationModeSwitch)
		self.allNotificationModeSwitch.snp.makeConstraints { make in
			make.top.equalTo(self.notificationModeTitleLabel.snp.bottom).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.standartEdge)
		}
		self.eventNotificationModeLabel.text = "Events"
		self.eventNotificationModeLabel.textColor = self.colors.mainViewColor.textColor
		self.eventNotificationModeLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.eventNotificationModeLabel)
		self.eventNotificationModeLabel.snp.makeConstraints { make in
			make.top.equalTo(self.allNotificationModeLabel.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.standartEdge)
		}
		self.eventNotificationModeSwitch = CustomSwitcher(color: self.colors)
		self.contentView.addSubview(self.eventNotificationModeSwitch)
		self.eventNotificationModeSwitch.snp.makeConstraints { make in
			make.top.equalTo(self.allNotificationModeSwitch.snp.bottom).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.standartEdge)
		}
		self.villagerBirthgayNotificationModeLabel.text = "Villagers Birthday"
		self.villagerBirthgayNotificationModeLabel.textColor = self.colors.mainViewColor.textColor
		self.villagerBirthgayNotificationModeLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.villagerBirthgayNotificationModeLabel)
		self.villagerBirthgayNotificationModeLabel.snp.makeConstraints { make in
			make.top.equalTo(self.eventNotificationModeSwitch.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.standartEdge)
		}
		self.villagerBirthgayNotificationModeSwitch = CustomSwitcher(color: self.colors)
		self.contentView.addSubview(self.villagerBirthgayNotificationModeSwitch)
		self.villagerBirthgayNotificationModeSwitch.snp.makeConstraints { make in
			make.top.equalTo(self.eventNotificationModeSwitch.snp.bottom).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.standartEdge)
		}
	}

	func setupAddVillagerTableHeader() {
		self.addVillagerButton.setImage(UIImage(named: AppImage.Settings.plus.rawValue),
										for: .normal)
		self.addVillagerButton.addTarget(self, action: #selector(addVillagerButtonTapped), for: .touchUpInside)
		self.contentView.addSubview(self.addVillagerButton)
		self.addVillagerButton.snp.makeConstraints { make in
			make.top.equalTo(self.villagerBirthgayNotificationModeSwitch.snp.bottom).offset(AppContraints.doubleEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.standartEdge)
			make.height.width.equalTo(AppContraints.Settings.heightButton)
		}
		self.addVillagerTitleLabel.text = "Add Villagers"
		self.addVillagerTitleLabel.textColor = self.colors.mainViewColor.textColor
		self.addVillagerTitleLabel.font = ACFont.defaultBoldFont.font
		self.contentView.addSubview(self.addVillagerTitleLabel)
		self.addVillagerTitleLabel.snp.makeConstraints { make in
			make.centerY.equalTo(self.addVillagerButton)
			make.leading.equalTo(self.contentView).offset(AppContraints.standartEdge)
			make.trailing.equalTo(self.addVillagerButton.snp.leading).offset(-AppContraints.minEdge)
		}
	}

	func setupAddVillagerTable() {
		self.addVillagerTable.delegate = self
		self.addVillagerTable.dataSource = self
		self.addVillagerTable.register(VillagerTableViewCell.self,
									   forCellReuseIdentifier: CellReusibleID.addVillagers.rawValue)
		self.contentView.addSubview(self.addVillagerTable)
		self.addVillagerTable.snp.makeConstraints { make in
			make.top.equalTo(self.addVillagerButton.snp.bottom).offset(AppContraints.standartEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.standartEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.standartEdge)
			make.height.equalTo(100)
		}
	}

	func setupSaveSettingsButton() {
		self.saveSettingsButton = OvalButton(withTitle: "Save",
											 width: AppContraints.Settings.widthButton,
											 height: AppContraints.Settings.heightButton,
											 color: self.colors)
		self.contentView.addSubview(self.saveSettingsButton)
		self.saveSettingsButton.snp.makeConstraints { make in
			make.top.equalTo(self.addVillagerTable.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.standartEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.standartEdge)
			make.bottom.equalTo(self.contentView).offset(-AppContraints.standartEdge)
		}
	}
}

@objc
extension NotificationSettingsView {
	func addVillagerButtonTapped(sender: UIButton) {
		print("addVillagerButtonTapped")
		self.controllerCallback?.addVillagerButtonTapped()
	}
}

extension NotificationSettingsView: UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.array.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: CellReusibleID.addVillagers.rawValue)
				as? VillagerTableViewCell
		else { return UITableViewCell() }
		cell.config(with: self.array[indexPath.row])
		return cell
	}
}
