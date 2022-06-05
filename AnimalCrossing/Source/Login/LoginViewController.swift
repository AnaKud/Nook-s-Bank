// LoginViewController.swift
// Created by Anastasiya Kudasheva on 10.06.2021.

import SnapKit
import UIKit

protocol ILoginViewController: INavigator, IAlertOnVC {
	func setupFullLoginView()
	func setupSimpleLoginView()
}

class LoginViewController: UIViewController {
	private var screen: Screen?

	private var interactor: ILoginInteractor

	private let fullLoginView = FullLoginView()
	private let simpleLoginView = SimpleLoginView(controllerTitle: AppTitle.nookBank)

	private let welcomeLabel = UILabel()
	private let appNameLabel = UILabel()
	private var emailTextField = UITextField()
	private var passwordNameTextField = UITextField()
	private var loginButton = UIButton()
	private var registerButton = UIButton()
	private var freeEnterButton = UIButton()
	private let warningLabel = UILabel()

	init(interactor: ILoginInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.addDissmissKeyboard()
		self.interactor.didLoadUI(vc: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.interactor.willAppearUI()
	}

	func setupFullLoginView() {
		self.screen = .loginScreen(.full)
		self.fullLoginView.setupCallBack(self.interactor)
		self.view = self.fullLoginView
	}

	func setupSimpleLoginView() {
		self.screen = .loginScreen(.simple)
		self.simpleLoginView.setupCallBack(self.interactor)
		self.simpleLoginView.clearPinView()
		self.view = self.simpleLoginView
	}
}

extension LoginViewController: ILoginViewController {
	func showAlert(title: String?, message: String, completion: (() -> Void)?) {
		DispatchQueue.main.async {
			let alert = CustomAlertController(title: title,
											  message: message,
											  preferredStyle: .alert)
			alert.changeAlertColors(for: self.screen)
			let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { _ in completion?() }
			alert.addAction(cancelAction)
			self.present(alert, animated: true)
		}
	}
}

private extension LoginViewController {
	func addDissmissKeyboard() {
		let tap = UITapGestureRecognizer(target: self,
										 action: #selector(self.dissmissKeyboard))
		tap.cancelsTouchesInView = false
		self.view.addGestureRecognizer(tap)
	}

	@objc
	func dissmissKeyboard() {
		self.view.endEditing(true)
	}
}

extension LoginViewController: INavigator {
	var currentVC: UIViewController? { return self }
}
