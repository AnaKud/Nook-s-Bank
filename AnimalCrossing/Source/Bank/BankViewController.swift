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
	var colors: ColorSet { ColorSet(for: self.screenType) }
	private(set) var screenType: ScreenType
	private(set) var controllerTitle = AppTitle.Bank.controllerTitle

	private lazy var topImageView = TopCloudyView(screenType: self.screenType)
	private lazy var bottomImageView = BottomCloudyView(screenType: self.screenType)

	private let titleLabel = UILabel()
	private let contentView = UIView()
	private lazy var bellsView = BankBellsView(callback: self.interactor, screenType: self.screenType)

	private var activityIndicatorView = UIActivityIndicatorView()

	private let interactor: IBankInteractor

	init(interactor: IBankInteractor, screenType: ScreenType) {
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
		
		self.view.addSubview(self.titleLabel)
		self.titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.view).offset(AppContraints.navTitle)
			make.leading.trailing.equalTo(self.view)
		}
		self.titleLabel.text = self.controllerTitle
		self.titleLabel.textAlignment = .center
		self.titleLabel.font = ACFont.controllerTitleFont.font

		self.titleLabel.numberOfLines = 0
		self.contentView.addSubview(self.bellsView)
		self.bellsView.snp.makeConstraints { make in
			make.edges.equalTo(self.contentView)
		}
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
}

extension BankViewController: IBankViewController {
	func initailInterface() {
		self.bellsView.isHidden = true
		self.activityIndicatorView.isHidden = false
	}

	func interfaceWithData() {
		self.bellsView.isHidden = false
		self.activityIndicatorView.stopAnimating()
		self.activityIndicatorView.isHidden = true
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
			let newExpense = ExpenseTransition(value: valueInt, currencyType: .bells, operationType: .minus, expenseType: ExpenseType.random())
			self.interactor.addExpenseOrIncome(newExpense)
		}

		let incomeAction = UIAlertAction(title: "Add Income", style: .default) { _ in
			guard let valueTextField = alert.textFields?[0],
				  let valueString = valueTextField.text,
				  let valueInt = Int(valueString)
			else { return }

			let newExpense = ExpenseTransition(value: valueInt, currencyType: .bells, operationType: .plus, expenseType: ExpenseType.random())
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
		self.bellsView.setNewTotalAccountValue(value)
	}

	func refreshCollectionView() {
		self.bellsView.refreshCollectionView()
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

extension BankViewController: INavigator {
	var currentVC: UIViewController? { return self }
}
