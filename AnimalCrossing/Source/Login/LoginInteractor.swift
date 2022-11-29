// LoginInteractor.swift
// Created by Anastasiya Kudasheva on 16.07.2021.

typealias ILoginInteractor = ILoginInteractorBusinessLogic & UIFullLoginViewCallBack & UISimpleLoginViewCallBack

protocol ILoginInteractorBusinessLogic {
	func didLoadUI(vc: LoginViewController)
	func willAppearUI()
}

protocol UISimpleLoginViewCallBack {
	func pinEndEditing(pin: String)
	func forgetPadButtonTapped()
	func touchIdButtonTapped()
}

protocol UIFullLoginViewCallBack {
	func loginButtonTapped(email: String?, password: String?)
	func continueButtonTapped()
	func registerButtonTapped(withUserName name: String?, email: String?, password: String?)
	func forgetPasswordButtonTapped(email: String?)
}

class LoginInteractor {
	private let presenter: ILoginPresenter
	private let worker: LoginWorker
	private let router: ILoginRouter

	init(presenter: ILoginPresenter, worker: LoginWorker, router: ILoginRouter) {
		self.presenter = presenter
		self.worker = worker
		self.router = router
	}
}

// MARK: - ILoginInteractorBusinessLogic
extension LoginInteractor: ILoginInteractorBusinessLogic {
	func didLoadUI(vc: LoginViewController) {
		self.presenter.setupVC(vc)
		self.router.setupVC(vc)
	}

	func willAppearUI() {
		self.presenter.presentScreen(for: self.setupScreenType())
		self.checkReachability()
	}
}

// MARK: - UIFullLoginViewCallBack
extension LoginInteractor: UIFullLoginViewCallBack {
	func loginButtonTapped(email: String?, password: String?) {
		self.worker.loginWithFirebase(email: email, password: password) { [weak self] result in
			switch result {
			case .success:
				self?.router.goToNextWithLogin()
			case let .error(error):
				self?.presenter.showError(with: error, completion: nil)
			}
		}
	}

	func continueButtonTapped() {
		//
	//	UserDefaultManager().setSimpleLogin()
		//
		self.router.goToNextWithoutLogin()
	}

	func registerButtonTapped(withUserName name: String?, email: String?, password: String?) {
		self.router.goToRegisterView()
	}

	func forgetPasswordButtonTapped(email: String?) {
		guard let email = email,
		!email.isEmpty else {
			self.presenter.showError(with: ValidationError.emailEmpty, completion: nil)
			return
		}
		self.worker.forgetPasswordButtonTapped(forEmail: email) { result in
			switch result {
			case .success:
				self.presenter.showSuccessEmailReminderAlert()
			case .failure(let error):
				self.presenter.showError(with: error, completion: nil)
			}
		}
	}
}

// MARK: - UISimpleLoginViewCallBack
extension LoginInteractor: UISimpleLoginViewCallBack {
	func forgetPadButtonTapped() {
		self.worker.forgetPadButtonTapped { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success:
				self.presenter.presentScreen(for: self.setupScreenType())
			case .failure(let error):
				self.presenter.showError(with: error, completion: nil)
			}
		}
	}

	func pinEndEditing(pin: String) {
		self.worker.simpleLogin(with: pin) { [weak self] result in
			switch result {
			case .success:
				self?.router.goToNextWithLogin()
			case let .error(error):
				self?.presenter.showError(with: error, completion: nil)
			}
		}
	}

	func touchIdButtonTapped() {
		self.worker.loginWithBiometric { [weak self] result in
			switch result {
			case .success:
				self?.router.goToNextWithLogin()
			case let .error(error):
				self?.presenter.showError(with: error, completion: nil)
			}
		}
	}
}

private extension LoginInteractor {
	func setupScreenType() -> Screen {
		return Screen(loginType: LoginType())
	}

	func checkReachability() {
		Reachability()
			.isConnectedToNetwork { [weak self] result in
				if result == false {
					self?.presenter.showError(with: InternetError.noInternet) {
						self?.router.goToNextWithoutInternetConnection()
					}
				}
			}
	}
}
