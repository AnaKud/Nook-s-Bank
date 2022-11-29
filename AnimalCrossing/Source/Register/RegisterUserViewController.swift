// RegisterUserViewController.swift
// Created by Anastasiya Kudasheva on 16.07.2021.

import UIKit

protocol IRegisterUserViewController: INavigator, IAlertOnVC { }

class RegisterUserViewController: SheetViewController {
	private let interactor: IRegisterUserInteractor
	private lazy var generalInfoView = RegisterUserView(callback: self.interactor)

	init(interactor: IRegisterUserInteractor) {
		self.interactor = interactor
		super.init(screenType: .additionalScreen)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.interactor.didLoadVC(self)
		self.setupHeader("Register User")
		self.loadUI()
		self.setupCallBack(self)
		self.showGeneralUserInfoView()
	}
}

private extension RegisterUserViewController {
	func showGeneralUserInfoView() {
		self.contentView.addSubview(self.generalInfoView)
		self.generalInfoView.snp.makeConstraints { make in
			make.top.leading.trailing.bottom.equalToSuperview()
		}
	}
}

extension RegisterUserViewController: ICloseButtonCallBack {
	func closeButtonAction() {
		self.interactor.closeButtonTapped()
	}
}

extension RegisterUserViewController: IRegisterUserViewController {
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
