//// BellsBankView.swift
//// Created by Anastasiya Kudasheva on 23.01.2022
//
//import UIKit
//
//class BankView: UIView {
//	
//}
//
//private extension BankView {
//	func setupContentViewLayout() {
//		self.view.addSubview(self.contentView)
//		self.contentView.snp.makeConstraints { make in
//			make.trailing.leading.equalTo(self.view)
//			make.top.equalTo(self.topImageView.snp.bottom).offset(AppContraints.minEdge)
//			make.bottom.equalTo(self.bottomImageView.snp.top).offset(-AppContraints.minEdge)
//		}
//		self.contentView.backgroundColor = .clear
//		if self.screenType != .loginScreen {
//			self.view.addSubview(self.titleLabel)
//			self.titleLabel.snp.makeConstraints { make in
//				make.top.equalTo(self.view).offset(AppContraints.navTitle)
//				make.leading.trailing.equalTo(self.view)
//			}
//			self.titleLabel.text = self.controllerTitle
//			self.titleLabel.textAlignment = .center
//			self.titleLabel.font = ACFont.controllerTitleFont.font
//		}
//		self.titleLabel.numberOfLines = 0
//	}
//
//	func displayActivity() {
//		self.contentView.addSubview(activityIndicatorView)
//		activityIndicatorView.snp.makeConstraints { make in
//			make.centerX.centerY.equalTo(contentView)
//		}
//		self.activityIndicatorView.style = .large
//		self.activityIndicatorView.color = self.colors.activityIndicatorColor.activityColor
//
//		self.activityIndicatorView.startAnimating()
//		self.activityIndicatorView.hidesWhenStopped = true
//	}
//
//	func dataForUser() {
//		switch screenType {
//		case .loggined:
//			currentAccountTitleLabel.text = AppTitle.Bank.currentAccountTitle
//			coinImageView.image = UIImage(named: AppImage.Bank.coinLogin.rawValue)
//			historyTitleLabel.text = AppTitle.Bank.purchaseHistory
//			plusImage = UIImage(named: AppImage.Bank.plusLogin.rawValue)
//		default:
//			currentAccountTitleLabel.text = AppTitle.Bank.demoTitle
//			coinImageView.image = UIImage(named: AppImage.Bank.coinUnLogin.rawValue)
//			historyTitleLabel.text = AppTitle.Bank.demoHistory
//			plusImage = UIImage(named: AppImage.Bank.plusUnlogin.rawValue)
//		}
//	}
//
//	func setupBankAccountView() {
//		self.contentView.addSubview(bankAccountView)
//		bankAccountView.snp.makeConstraints { make in
//			make.leading.top.equalTo(self.contentView).offset(AppContraints.midEdge)
//			make.trailing.equalTo(self.contentView).offset(-AppContraints.midEdge)
//			make.height.equalTo(AppContraints.Bank.bankAccountViewHeight)
//		}
//		bankAccountView.layer.cornerRadius = AppContraints.standartCornerRadius
//		bankAccountView.backgroundColor = self.colors.bankViewColor.backgroundViewColor
//
//		bankAccountView.addSubview(coinImageView)
//		coinImageView.snp.makeConstraints { make in
//			make.top.leading.equalTo(bankAccountView).offset(AppContraints.minEdge)
//			make.bottom.equalTo(bankAccountView).offset(-AppContraints.minEdge)
//			make.width.equalTo(coinImageView.snp.height)
//		}
//
//		bankAccountView.addSubview(currentAccountTitleLabel)
//		currentAccountTitleLabel.snp.makeConstraints { make in
//			make.leading.equalTo(coinImageView.snp.trailing).offset(AppContraints.midEdge)
//			make.top.equalTo(bankAccountView).offset(AppContraints.minEdge)
//			make.trailing.equalTo(bankAccountView).offset(-AppContraints.minEdge)
//		}
//		currentAccountTitleLabel.font = ACFont.bankAccountFont.font
//		currentAccountTitleLabel.textColor = self.colors.bankViewColor.titleTextColor
//
//		bankAccountView.addSubview(currentAccountLabel)
//		currentAccountLabel.snp.makeConstraints { make in
//			make.leading.equalTo(coinImageView.snp.trailing).offset(AppContraints.midEdge)
//			make.top.equalTo(currentAccountTitleLabel.snp.bottom).offset(AppContraints.minEdge)
//			make.trailing.bottom.equalTo(bankAccountView).offset(-AppContraints.minEdge)
//		}
//		currentAccountLabel.font = ACFont.bankAccountFont.font
//		currentAccountLabel.textColor = self.colors.bankViewColor.itemTextColor
//		currentAccountLabel.text = self.presenter.returnCurrentAccountValue()
//	}
//
//	func setupPlusButton() {
//		self.contentView.addSubview(plusButton)
//		plusButton.snp.makeConstraints { make in
//			make.centerX.equalTo(contentView)
//			make.bottom.equalTo(contentView).offset(-AppContraints.minEdge)
//			make.height.width.equalTo(AppContraints.Bank.plusButtonHeight)
//		}
//
//		plusButton.setImage(plusImage, for: .normal)
//		plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
//	}
//
//	func setupViewForCollection() {
//		self.contentView.addSubview(historyView)
//		historyView.snp.makeConstraints { make in
//			make.top.equalTo(bankAccountView.snp.bottom).offset(AppContraints.midEdge)
//			make.leading.equalTo(self.contentView).offset(AppContraints.midEdge)
//			make.trailing.equalTo(self.contentView).offset(-AppContraints.midEdge)
//			make.bottom.equalTo(plusButton.snp.top).offset(-AppContraints.midEdge)
//		}
//		historyView.layer.cornerRadius = AppContraints.standartCornerRadius
//		historyView.backgroundColor = self.colors.bankViewColor.backgroundViewColor
//		historyView.layer.masksToBounds = true
//
//		historyView.addSubview(historyTitleLabel)
//		historyTitleLabel.snp.makeConstraints { make in
//			make.leading.equalTo(historyView).offset(AppContraints.midEdge)
//			make.top.equalTo(historyView).offset(AppContraints.minEdge)
//			make.trailing.equalTo(historyView).offset(-AppContraints.midEdge)
//		}
//		historyTitleLabel.font = ACFont.bankAccountFont.font
//		historyTitleLabel.textColor = self.colors.bankViewColor.titleTextColor
//
//		historyView.addSubview(expensesCollectionView)
//		expensesCollectionView.snp.makeConstraints { make in
//			make.top.equalTo(historyTitleLabel.snp.bottom).offset(AppContraints.minEdge)
//			make.leading.trailing.bottom.equalTo(historyView)
//		}
//		expensesCollectionView.backgroundColor = .clear
//	}
//
//	func setupCollectionView() {
//		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .vertical
//		layout.minimumLineSpacing = AppContraints.midEdge
//		expensesCollectionView.collectionViewLayout = layout
//		self.expensesCollectionView.delegate = self
//		self.expensesCollectionView.dataSource = self
//		expensesCollectionView.register(ExpenseCollectionViewCell.self,
//										forCellWithReuseIdentifier: CellReusibleID.expense.rawValue)
//	}
//}