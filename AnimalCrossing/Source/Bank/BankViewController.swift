// BankViewController.swift
// Created by Anastasiya Kudasheva on 13.06.2021.

import UIKit

protocol IBankViewController: INavigator {
	func interfaceWithData()
	func setNewTotalAccountValue(_ value: String)
	func refreshCollectionView()
	func showAddExpenseAlert()
	func showErrorAlert(title: String?, message: String, handler: (() -> Void)?)
}

class BankViewController: UIPageViewController {
	var colors: ColorSet {
		ColorSet(for: self.screenType)
	}
	var screenType: ScreenTypes
	var controllerTitle = AppTitle.Bank.controllerTitle

	private lazy var topImageView = TopCloudyView(screenType: self.screenType)

	private lazy var bottomImageView = BottomCloudyView(screenType: self.screenType)

	private let contentView = UIView()
	private let titleLabel = UILabel()

	private let bankAccountView = UIView()
	private let coinImageView = UIImageView()
	private let currentAccountTitleLabel = UILabel()
	private let currentAccountLabel = UILabel()
	private let historyTitleLabel = UILabel()
	private let historyView = UIView()
	private var expensesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	private let plusButton = UIButton()
	private var plusImage: UIImage?
	private var activityIndicatorView = UIActivityIndicatorView()

	private let interactor: IBankInteractor

	private lazy var bankViewDelegate: BankViewDelegate = {
		BankViewDelegate(interactor: self.interactor,
						 colors: ColorSet(for: self.screenType))
	}()

	init(interactor: IBankInteractor, screenType: ScreenTypes) {
		self.interactor = interactor
		self.screenType = screenType
		super.init(transitionStyle: .pageCurl,
				   navigationOrientation: .horizontal,
				   options: [:])
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadUI()
		self.displayActivity()
		self.initailInterface()
		self.dataForUser()
		self.interactor.loadVC(self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	func loadUI() {
		self.screenTypeSettings()
		self.setupTopLayout()
		self.setupBottomLayout()
		self.setupContentViewLayout()
		self.screenTypeSettings()
		self.setupTopLayout()
		self.setupBottomLayout()
		self.setupContentViewLayout()
	}

	func setupTopLayout() {
		self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationController?.navigationBar.barStyle = .default
		self.navigationController?.navigationBar.tintColor = self.colors.mainViewColor.navigationItemColor

		self.view.addSubview(self.topImageView)
		self.topImageView.snp.makeConstraints { make in
			make.top.trailing.leading.equalTo(self.view)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
	}

	func setupContentViewLayout() {
		self.view.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.trailing.leading.equalTo(self.view)
			make.top.equalTo(self.topImageView.snp.bottom).offset(AppContraints.minEdge)
			make.bottom.equalTo(self.bottomImageView.snp.top).offset(-AppContraints.minEdge)
		}
		self.contentView.backgroundColor = .clear
		if self.screenType != .loginScreen {
			self.view.addSubview(self.titleLabel)
			self.titleLabel.snp.makeConstraints { make in
				make.top.equalTo(self.view).offset(AppContraints.navTitle)
				make.leading.trailing.equalTo(self.view)
			}
			self.titleLabel.text = self.controllerTitle
			self.titleLabel.textAlignment = .center
			self.titleLabel.font = ACFont.controllerTitleFont.font
		}
		self.titleLabel.numberOfLines = 0
	}

	func setupBottomLayout() {
		self.tabBarController?.tabBar.barTintColor = UIColor.clear
		self.tabBarController?.tabBar.backgroundImage = UIImage()
		self.tabBarController?.tabBar.shadowImage = UIImage()

		self.view.addSubview(self.bottomImageView)
		self.bottomImageView.snp.makeConstraints { make in
			make.bottom.trailing.leading.equalTo(self.view)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
	}

	func screenTypeSettings() {
		self.view.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.titleLabel.textColor = self.colors.mainViewColor.textColor
	}

	private func displayActivity() {
		self.contentView.addSubview(activityIndicatorView)
		activityIndicatorView.snp.makeConstraints { make in
			make.centerX.centerY.equalTo(contentView)
		}
		self.activityIndicatorView.style = .large
		self.activityIndicatorView.color = self.colors.activityIndicatorColor.activityColor

		self.activityIndicatorView.startAnimating()
		self.activityIndicatorView.hidesWhenStopped = true
	}

	private func dataForUser() {
		switch screenType {
		case .loggined:
			currentAccountTitleLabel.text = AppTitle.Bank.currentAccountTitle
			coinImageView.image = UIImage(named: AppImage.Bank.coinLogin.rawValue)
			historyTitleLabel.text = AppTitle.Bank.purchaseHistory
			plusImage = UIImage(named: AppImage.Bank.plusLogin.rawValue)
		default:
			currentAccountTitleLabel.text = AppTitle.Bank.demoTitle
			coinImageView.image = UIImage(named: AppImage.Bank.coinUnLogin.rawValue)
			historyTitleLabel.text = AppTitle.Bank.demoHistory
			plusImage = UIImage(named: AppImage.Bank.plusUnlogin.rawValue)
		}
	}

	private func setupBankAccountView() {
		self.contentView.addSubview(bankAccountView)
		bankAccountView.snp.makeConstraints { make in
			make.leading.top.equalTo(self.contentView).offset(AppContraints.midEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.midEdge)
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
		currentAccountLabel.text = self.interactor.returnCurrentAccountValue()
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
		self.expensesCollectionView.delegate = self.bankViewDelegate
		self.expensesCollectionView.dataSource = self.bankViewDelegate
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.minimumLineSpacing = AppContraints.midEdge
		expensesCollectionView.collectionViewLayout = layout
		expensesCollectionView.register(ExpenseCollectionViewCell.self,
										forCellWithReuseIdentifier: CellReusibleID.expense.rawValue)
	}
}

extension BankViewController: IBankViewController {
	func initailInterface() {
		bankAccountView.isHidden = true
		coinImageView.isHidden = true
		historyView.isHidden = true
		expensesCollectionView.isHidden = true
		plusButton.isHidden = true
		activityIndicatorView.isHidden = false
	}

	func interfaceWithData() {
		self.setupBankAccountView()
		self.setupPlusButton()
		self.setupViewForCollection()
		self.setupCollectionView()
		bankAccountView.isHidden = false
		coinImageView.isHidden = false
		historyView.isHidden = false
		expensesCollectionView.isHidden = false
		plusButton.isHidden = false
		activityIndicatorView.stopAnimating()
		activityIndicatorView.isHidden = true
	}

	func showAddExpenseAlert() {
		let alert = CustomAlertController(title: AppTitle.Bank.newExpense, message: nil, preferredStyle: .alert)
		alert.changeAlertColors(for: self.screenType)
		alert.addTextField { valueTextField in
			valueTextField.placeholder = "Bells"
			valueTextField.keyboardType = .decimalPad
			if #available(iOS 14.0, *) {
				valueTextField.addAction(UIAction(handler: { _ in
					if valueTextField.text?.isEmpty ?? true {
						alert.actions[0].isEnabled = false
						alert.actions[1].isEnabled = false
					} else {
						alert.actions[0].isEnabled = true
						alert.actions[1].isEnabled = true
					}
				}), for: .editingChanged)
			} else { }
		}

		let expenseAction = UIAlertAction(title: "Add Expense", style: .default) { _ in
			guard let valueTextField = alert.textFields?[0],
				  let valueString = valueTextField.text,
				  let valueInt = Int(valueString)
			else { return }
			let newExpense = ExpenseTransition(value: valueInt, operationType: .minus, expenseType: ExpenseType.random())
			self.interactor.addExpenseOrIncome(newExpense)
		}

		let incomeAction = UIAlertAction(title: "Add Income", style: .default) { _ in
			guard let valueTextField = alert.textFields?[0],
				  let valueString = valueTextField.text,
				  let valueInt = Int(valueString)
			else { return }

			let newExpense = ExpenseTransition(value: valueInt, operationType: .plus, expenseType: ExpenseType.random())
			self.interactor.addExpenseOrIncome(newExpense)
		}

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		alert.addAction(expenseAction)
		alert.addAction(incomeAction)
		alert.addAction(cancelAction)
		expenseAction.isEnabled = false
		incomeAction.isEnabled = false
		self.present(alert, animated: true)
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

	func showErrorAlert(title: String?, message: String, handler: (() -> Void)?) {
		let alert = CustomAlertController(title: title,
										  message: message,
										  preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default) { _ in
			handler?()
		}
		alert.addAction(action)
		self.present(alert, animated: true)
	}
}

@objc extension BankViewController {
	func plusButtonTapped(sender: UIButton) {
		self.interactor.plusButtonTapped()
	}
}

extension BankViewController: INavigator {
	var currentVC: UIViewController? { return self }
}
