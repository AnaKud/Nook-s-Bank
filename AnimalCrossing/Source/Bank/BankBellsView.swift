// BankBellsView.swift
// Created by Anastasiya Kudasheva on 01.01.2022.

import UIKit

protocol IBankBellsViewCallback: IBankViewDelegate {
	func plusButtonTapped()
	func minusButtonTapped()
}

class BankBellsView: UIView {
	private let callback: IBankBellsViewCallback
	private var colors: ColorSet { ColorSet(for: self.screenType) }
	private var screenType: ScreenType

	private let bankAccountView = UIView()
	private let coinImageView = UIImageView()
	private let currentAccountTitleLabel = UILabel()
	private let currentAccountLabel = UILabel()
	private let historyTitleLabel = UILabel()
	private let historyView = UIView()
	private var expensesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	private lazy var plusButton = PlusMinusButton(expenceType: .plus,
												  screenType: self.screenType)
	private lazy var minusButton = PlusMinusButton(expenceType: .minus,
												   screenType: self.screenType)

	private lazy var bankViewDelegate = BankViewDelegate(viewCallback: self.callback,
														 colors: self.colors)

	init(callback: IBankBellsViewCallback, screenType: ScreenType) {
		self.callback = callback
		self.screenType = screenType
		super.init(frame: .zero)
		self.loadUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setNewTotalAccountValue(_ value: String) {
		DispatchQueue.main.async {
			self.currentAccountLabel.text = value
		}
	}

	func refreshCollectionView() {
		DispatchQueue.main.async {
			self.expensesCollectionView.reloadData()
		}
	}
}

private extension BankBellsView {
	func loadUI() {
		self.screenTypeSettings()
		self.setupBankAccountView()
		self.setupPlusButton()
		self.setupMinusButton()
		self.setupViewForCollection()
		self.setupCollectionView()
	}

	func screenTypeSettings() {
		self.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.displayLabels()
	}

	func displayLabels() {
		switch self.screenType {
		case .unlogined, .additionalScreen:
			self.currentAccountTitleLabel.text = AppTitle.Bank.demoTitle
			self.coinImageView.image = UIImage(named: AppImage.Bank.coinUnLogin.rawValue)
			self.historyTitleLabel.text = AppTitle.Bank.demoHistory
		case .logined:
			self.currentAccountTitleLabel.text = AppTitle.Bank.currentAccountTitle
			self.coinImageView.image = UIImage(named: AppImage.Bank.coinLogin.rawValue)
			self.historyTitleLabel.text = AppTitle.Bank.purchaseHistory
		}
	}

	func setupBankAccountView() {
		self.addSubview(self.bankAccountView)
		self.bankAccountView.snp.makeConstraints { make in
			make.leading.top.equalTo(self).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.midEdge)
			make.height.equalTo(AppContraints.Bank.bankAccountViewHeight)
		}
		self.bankAccountView.layer.cornerRadius = AppContraints.standartCornerRadius
		self.bankAccountView.backgroundColor = self.colors.bankViewColor.backgroundViewColor

		self.bankAccountView.addSubview(self.coinImageView)
		self.coinImageView.snp.makeConstraints { make in
			make.top.leading.equalTo(self.bankAccountView).offset(AppContraints.minEdge)
			make.bottom.equalTo(self.bankAccountView).offset(-AppContraints.minEdge)
			make.width.equalTo(self.coinImageView.snp.height)
		}
		self.bankAccountView.addSubview(self.currentAccountTitleLabel)
		self.currentAccountTitleLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.coinImageView.snp.trailing).offset(AppContraints.midEdge)
			make.top.equalTo(self.bankAccountView).offset(AppContraints.minEdge)
			make.trailing.equalTo(self.bankAccountView).offset(-AppContraints.minEdge)
		}
		self.currentAccountTitleLabel.font = ACFont.bankAccountFont.font
		self.currentAccountTitleLabel.textColor = self.colors.bankViewColor.titleTextColor

		self.bankAccountView.addSubview(self.currentAccountLabel)
		self.currentAccountLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.coinImageView.snp.trailing).offset(AppContraints.midEdge)
			make.top.equalTo(self.currentAccountTitleLabel.snp.bottom).offset(AppContraints.minEdge)
			make.trailing.bottom.equalTo(self.bankAccountView).offset(-AppContraints.minEdge)
		}
		self.currentAccountLabel.font = ACFont.bankAccountFont.font
		self.currentAccountLabel.textColor = self.colors.bankViewColor.itemTextColor
	}

	func setupPlusButton() {
		self.addSubview(self.plusButton)
		self.plusButton.snp.makeConstraints { make in
			make.bottom.equalTo(self).offset(-AppContraints.minEdge)
			make.height.width.equalTo(AppContraints.Bank.plusButtonHeight)
			make.trailing.equalTo(self).offset(-AppContraints.doubleEdge)
		}
		self.plusButton.addTarget(self, action: #selector(self.plusButtonTapped), for: .touchUpInside)
	}

	func setupMinusButton() {
		self.addSubview(self.minusButton)
		self.minusButton.snp.makeConstraints { make in
			make.bottom.equalTo(self).offset(-AppContraints.minEdge)
			make.height.width.equalTo(AppContraints.Bank.plusButtonHeight)
			make.leading.equalTo(self).offset(AppContraints.doubleEdge)
		}
		self.minusButton.addTarget(self, action: #selector(self.minusButtonTapped), for: .touchUpInside)
	}

	func setupViewForCollection() {
		self.addSubview(historyView)
		self.historyView.snp.makeConstraints { make in
			make.top.equalTo(self.bankAccountView.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.midEdge)
			make.bottom.equalTo(self.plusButton.snp.top).offset(-AppContraints.midEdge)
		}
		self.historyView.layer.cornerRadius = AppContraints.standartCornerRadius
		self.historyView.backgroundColor = self.colors.bankViewColor.backgroundViewColor
		self.historyView.layer.masksToBounds = true

		self.historyView.addSubview(self.historyTitleLabel)
		self.historyTitleLabel.snp.makeConstraints { make in
			make.leading.equalTo(self.historyView).offset(AppContraints.midEdge)
			make.top.equalTo(self.historyView).offset(AppContraints.minEdge)
			make.trailing.equalTo(self.historyView).offset(-AppContraints.midEdge)
		}
		self.historyTitleLabel.font = ACFont.bankAccountFont.font
		self.historyTitleLabel.textColor = self.colors.bankViewColor.titleTextColor

		self.historyView.addSubview(self.expensesCollectionView)
		self.expensesCollectionView.snp.makeConstraints { make in
			make.top.equalTo(self.historyTitleLabel.snp.bottom).offset(AppContraints.minEdge)
			make.leading.trailing.bottom.equalTo(self.historyView)
		}
		self.expensesCollectionView.backgroundColor = .clear
	}

	func setupCollectionView() {
		self.expensesCollectionView.delegate = self.bankViewDelegate
		self.expensesCollectionView.dataSource = self.bankViewDelegate
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = AppContraints.midEdge
		self.expensesCollectionView.collectionViewLayout = layout
		self.expensesCollectionView.register(ExpenseCollectionViewCell.self,
											 forCellWithReuseIdentifier: CellReusibleID.expense.rawValue)
	}
}

@objc extension BankBellsView {
	func plusButtonTapped(sender: UIButton) {
		self.callback.plusButtonTapped()
	}

	func minusButtonTapped(sender: UIButton) {
		self.callback.minusButtonTapped()
	}
}
