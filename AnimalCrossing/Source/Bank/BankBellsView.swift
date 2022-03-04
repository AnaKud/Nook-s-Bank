// BankBellsView.swift
// Created by Anastasiya Kudasheva on 01.01.2022.

import UIKit

class BankBellsView: UIView {
	private let presenter: BankPresenter

	private let colors = ColorSet(for: .loggined)

	private let contentView = UIView()
	private let bankAccountView = UIView()
	private let coinImageView = UIImageView()
	private let currentAccountTitleLabel = UILabel()
	private let currentAccountLabel = UILabel()
	private let plusButton = UIButton()
	private var plusImage: UIImage?

	private let historyView = UIView()
	private let historyTitleLabel = UILabel()
	private let expensesCollectionView = UICollectionView()

	init(presenter: BankPresenter) {
		self.presenter = presenter
		super.init(frame: .zero)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupBankAccountView() {
		self.addSubview(bankAccountView)
		bankAccountView.snp.makeConstraints { make in
			make.leading.top.equalTo(self).offset(AppContraints.midEdge)
			make.trailing.equalTo(self).offset(-AppContraints.midEdge)
			make.height.equalTo(AppContraints.Bank.bankAccountViewHeight)
		}
		bankAccountView.layer.cornerRadius = AppContraints.standartCornerRadius
		bankAccountView.backgroundColor = self.colors.bankViewColor.backgroundViewColor

		bankAccountView.addSubview(coinImageView)
		coinImageView.snp.makeConstraints { make in
			make.top.leading.equalTo(bankAccountView).offset(AppContraints.minEdge)
			make.bottom.equalTo(bankAccountView).offset(-AppContraints.minEdge)
			make.width.equalTo(coinImageView.snp.height)
		}

		bankAccountView.addSubview(currentAccountTitleLabel)
		currentAccountTitleLabel.snp.makeConstraints { make in
			make.leading.equalTo(coinImageView.snp.trailing).offset(AppContraints.midEdge)
			make.top.equalTo(bankAccountView).offset(AppContraints.minEdge)
			make.trailing.equalTo(bankAccountView).offset(-AppContraints.minEdge)
		}
		currentAccountTitleLabel.font = ACFont.bankAccountFont.font
		currentAccountTitleLabel.textColor = self.colors.bankViewColor.titleTextColor

		bankAccountView.addSubview(currentAccountLabel)
		currentAccountLabel.snp.makeConstraints { make in
			make.leading.equalTo(coinImageView.snp.trailing).offset(AppContraints.midEdge)
			make.top.equalTo(currentAccountTitleLabel.snp.bottom).offset(AppContraints.minEdge)
			make.trailing.bottom.equalTo(bankAccountView).offset(-AppContraints.minEdge)
		}
		currentAccountLabel.font = ACFont.bankAccountFont.font
		currentAccountLabel.textColor = self.colors.bankViewColor.itemTextColor
		currentAccountLabel.text = self.presenter.returnCurrentAccountValue()
	}

	private func setupPlusButton() {
		self.contentView.addSubview(plusButton)
		plusButton.snp.makeConstraints { make in
			make.centerX.equalTo(contentView)
			make.bottom.equalTo(contentView).offset(-AppContraints.minEdge)
			make.height.width.equalTo(AppContraints.Bank.plusButtonHeight)
		}

		plusButton.setImage(plusImage, for: .normal)
		plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
	}

	private func setupViewForCollection() {
		self.contentView.addSubview(historyView)
		historyView.snp.makeConstraints { make in
			make.top.equalTo(bankAccountView.snp.bottom).offset(AppContraints.midEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.midEdge)
			make.bottom.equalTo(plusButton.snp.top).offset(-AppContraints.midEdge)
		}
		historyView.layer.cornerRadius = AppContraints.standartCornerRadius
		historyView.backgroundColor = self.colors.bankViewColor.backgroundViewColor
		historyView.layer.masksToBounds = true

		historyView.addSubview(historyTitleLabel)
		historyTitleLabel.snp.makeConstraints { make in
			make.leading.equalTo(historyView).offset(AppContraints.midEdge)
			make.top.equalTo(historyView).offset(AppContraints.minEdge)
			make.trailing.equalTo(historyView).offset(-AppContraints.midEdge)
		}
		historyTitleLabel.font = ACFont.bankAccountFont.font
		historyTitleLabel.textColor = self.colors.bankViewColor.titleTextColor

		historyView.addSubview(expensesCollectionView)
		expensesCollectionView.snp.makeConstraints { make in
			make.top.equalTo(historyTitleLabel.snp.bottom).offset(AppContraints.minEdge)
			make.leading.trailing.bottom.equalTo(historyView)
		}
		expensesCollectionView.backgroundColor = .clear
	}

	private func setupCollectionView() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = AppContraints.midEdge
		expensesCollectionView.collectionViewLayout = layout
//		self.expensesCollectionView.delegate = self
//		self.expensesCollectionView.dataSource = self
		expensesCollectionView.register(ExpenseCollectionViewCell.self,
										forCellWithReuseIdentifier: CellReusibleID.expense.rawValue)
	}
	@objc
	func plusButtonTapped() {
	}
}

class PlusMinusButton: UIButton {
	private let expenceType: OperationType
	private let screenType: ScreenTypes
	private var buttonImage: UIImage?

	init(expenceType: OperationType, screenType: ScreenTypes) {
		self.expenceType = expenceType
		self.screenType = screenType
		super.init(frame: .zero)
		self.loadUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension PlusMinusButton {
	func loadUI() {
		switch (self.expenceType, self.screenType) {
		case (.plus, .loggined):
			self.buttonImage = UIImage(named: AppImage.Bank.plusLogin.rawValue)
		case (.minus, .loggined):
			self.buttonImage = UIImage(named: AppImage.Bank.plusLogin.rawValue)
		case (.plus, _):
			self.buttonImage = UIImage(named: AppImage.Bank.plusUnlogin.rawValue)
		case (.minus, _):
			self.buttonImage = UIImage(named: AppImage.Bank.plusUnlogin.rawValue)
		}
	}
}
