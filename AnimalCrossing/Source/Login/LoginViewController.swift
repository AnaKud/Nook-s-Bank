// LoginViewController.swift
// Created by Anastasiya Kudasheva on 10.06.2021.

import SnapKit
import UIKit

protocol ILoginViewController: AnyObject, IAlertOnVC {
	func setupFullLoginView()
	func setupSimpleLoginView()
}

class LoginViewController: UIViewController {
	private lazy var colors = ColorSet(for: self.screenType)
	private var screenType: ScreenTypes?

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
		self.setupNavigationController()
		self.addDissmissKeyboard()
		self.interactor.didLoadUI(vc: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.interactor.willAppearUI()
	}

	func setupFullLoginView() {
		self.screenType = .loginScreen
		self.fullLoginView.setupCallBack(self.interactor)
		self.view = self.fullLoginView
	}

	func setupSimpleLoginView() {
		self.screenType = .other
		self.simpleLoginView.setupCallBack(self.interactor)
		self.simpleLoginView.clearPinView()
		self.view = self.simpleLoginView
	}
}

extension LoginViewController: ILoginViewController {
	func showAlert(with message: String, completion: (() -> Void)? = nil) {
		DispatchQueue.main.async {
			let alert = CustomAlertController(title: nil,
											  message: message,
											  preferredStyle: .alert)
			alert.changeAlertColors(for: self.screenType)
			let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { _ in completion?() }
			alert.addAction(cancelAction)
			self.present(alert, animated: true)
		}
	}
}

private extension LoginViewController {
	func setupNavigationController() {
		self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.topItem?.title = ""
		self.navigationController?.navigationBar.barStyle = .default
	}

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
