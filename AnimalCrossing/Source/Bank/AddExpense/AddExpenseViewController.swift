// AddExpenseViewController.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

protocol IAddExpenseViewController: INavigator, IAlertOnVC {
	func setupHeader(_ text: String)
	func reloadView()
	func getText() -> String?
}

final class AddExpenseViewController: UIViewController {
	private lazy var colors = ColorSet(for: .logined(self.screenType))
	private let screenType: LoginedScreenType

	private let titleLabel = UILabel()
	private lazy var textfield = CustomTextField(settings: .init(color: self.colors,
																 cornerRadius: AppContraints.AddExpense.cornerRadius))
	private let contentView = UIView()
	private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
	private lazy var calcelButton = OvalButton(withTitle: "Cancel",
											   width: AppContraints.Login.widthButton,
											   height: AppContraints.Login.heightButtons,
											   color: self.colors)

	private lazy var saveButton = OvalButton(withTitle: "Save",
											 width: AppContraints.Login.widthButton,
											 height: AppContraints.Login.heightButtons,
											 color: self.colors)

	private let presenter: IAddExpensePresenter
	private lazy var delegate = AddExpenseViewDelegate(callback: self.presenter)

	init(screenType: LoginedScreenType, presenter: IAddExpensePresenter) {
		self.screenType = screenType
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureView()
		self.presenter.didLoad(self)
	}
}

private extension AddExpenseViewController {
	func configureView() {
		self.screenTypeSettings()
		self.setupTitleLabel()
		self.setupButtons()
		self.setupTextfield()
		self.setupCollectionView()
	}

	func screenTypeSettings() {
		self.view.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.titleLabel.textColor = self.colors.mainViewColor.textColor
	}

	func setupTitleLabel() {
		self.view.addSubview(self.titleLabel)
		self.titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.view).offset(AppContraints.navTitle)
			make.trailing.leading.equalTo(self.view)
		}
		self.titleLabel.textAlignment = .center
		self.titleLabel.font = ACFont.controllerTitleFont.font
		self.titleLabel.numberOfLines = 0
	}

	func setupTextfield() {
		self.view.addSubview(self.textfield)
		self.textfield.snp.makeConstraints { make in
			make.top.equalTo(self.calcelButton.snp.bottom).offset(AppContraints.midEdge)
			make.top.equalTo(self.saveButton.snp.bottom).offset(AppContraints.midEdge)
			make.height.equalTo(AppContraints.Login.heightTF)
			make.trailing.equalTo(self.view).offset(-AppContraints.doubleEdge)
			make.leading.equalTo(self.view).offset(AppContraints.doubleEdge)
		}
		self.textfield.keyboardType = .numberPad
	}

	func setupCollectionView() {
		self.view.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.top.equalTo(self.textfield.snp.bottom).offset(AppContraints.standartEdge)
			make.leading.equalTo(self.view).offset(AppContraints.standartEdge)
			make.trailing.equalTo(self.view).offset(-AppContraints.standartEdge)
			make.height.lessThanOrEqualTo(AppContraints.AddExpense.collectionViewHeight)
		}
		self.view.addSubview(self.collectionView)
		self.collectionView.snp.makeConstraints { make in
			make.leading.top.equalTo(self.contentView).offset(AppContraints.standartEdge)
			make.trailing.bottom.equalTo(self.contentView).offset(-AppContraints.standartEdge)
			make.height.equalTo(self.contentView)
		}
		self.collectionView.backgroundColor = .clear
		self.collectionView.delegate = self.delegate
		self.collectionView.dataSource = self.delegate

		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical

		self.collectionView.collectionViewLayout = layout
		self.collectionView.register(AddExpenseCollectionViewCell.self,
									 forCellWithReuseIdentifier: CellReusibleID.addExpense.rawValue)
	}

	func setupButtons() {
		self.view.addSubview(self.calcelButton)
		self.calcelButton.snp.makeConstraints { make in
			make.trailing.equalTo(self.view.snp.centerX).offset(-AppContraints.doubleEdge)
			make.height.equalTo(AppContraints.Login.heightButtons)
			make.top.equalTo(self.titleLabel.snp.bottom).offset(AppContraints.midEdge)
		}
		self.calcelButton.addTarget(self,
									action: #selector(self.cancelButtonTapped),
									for: .touchUpInside)
		self.view.addSubview(self.saveButton)
		self.saveButton.snp.makeConstraints { make in
			make.leading.equalTo(self.view.snp.centerX).offset(AppContraints.doubleEdge)
			make.height.equalTo(AppContraints.Login.heightButtons)
			make.top.equalTo(self.titleLabel.snp.bottom).offset(AppContraints.midEdge)
		}
		self.saveButton.addTarget(self,
								  action: #selector(self.saveButtonTapped),
								  for: .touchUpInside)
	}
}

@objc
private extension AddExpenseViewController {
	func saveButtonTapped() {
		self.presenter.saveButtonTapped(self.textfield.text)
	}

	func cancelButtonTapped() {
		self.presenter.cancelButtonTapped()
	}
}

extension AddExpenseViewController: IAddExpenseViewController {
	func getText() -> String? {
		return self.textfield.text
	}

	func setupHeader(_ text: String) {
		self.titleLabel.text = text
	}

	func reloadView() {
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
	}
}

extension AddExpenseViewController: IAlertOnVC {
	func showAlert(title: String?, message: String, completion: (() -> Void)?) {
		let alert = CustomAlertController(title: title,
										  message: message,
										  preferredStyle: .alert)
		alert.changeAlertColors(for: self.screenType)
		let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { _ in completion?() }
		alert.addAction(cancelAction)
		self.present(alert, animated: true)
	}
}

extension AddExpenseViewController: INavigator {
	var currentVC: UIViewController? { return self }
}
