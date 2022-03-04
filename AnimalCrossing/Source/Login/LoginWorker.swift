// LoginWorker.swift
// Created by Anastasiya Kudasheva on 16.07.2021.

import Foundation

class LoginWorker {
	private var fireBaseManager: ILoginFireBaseManager
	private var keychainService: IKeychainService
	private var authenticationService: IDeviceOwnerAuthentication
	private let userDefaultManager = UserDefaultManager()

	init(fireBaseManager: ILoginFireBaseManager,
		 keychainService: IKeychainService,
		 authenticationService: IDeviceOwnerAuthentication) {
		self.fireBaseManager = fireBaseManager
		self.keychainService = keychainService
		self.authenticationService = authenticationService
	}

	func loginWithBiometric(completion: @escaping (LoginResult) -> Void) {
		self.authenticationService.authenticationRequest { result in
			switch result {
			case .success:
				self.fireBaseManager.simpleLogin(completion: completion)
			case .failure:
				completion(.error(.biometricAuthError))
			}
		}
	}

	func loginWithFirebase(email: String?, password: String?, completion: @escaping (LoginResult) -> Void) {
		LoginDataValidator.check(email: email, password: password) { [weak self] result in
			self?.processLoginValidationResult(result, completion: completion)
		}
	}

	func forgetPasswordButtonTapped() {
		print("forgetPasswordButtonTapped")
	}

	func forgetPadButtonTapped(completion: @escaping (ACResult<Void, LogoutError>) -> Void) {
		self.userDefaultManager.removeSimpleLogin() ? completion(.success(())) : completion(.failure(.padDelete))
	}

	func simpleLogin(with pin: String, completion: @escaping (LoginResult) -> Void) {
		self.fireBaseManager.simpleLogin(withPad: pin, completion: completion)
	}
}

private extension LoginWorker {
	func processLoginValidationResult(_ result: LoginValidationResult,
									  completion: @escaping (LoginResult) -> Void) {
		switch result {
		case let .success(email, password):
			self.fireBaseManager.login(withEmail: email,
									   withPassword: password, completion: completion)
		case let .error(error):
			completion(.error(LoginError(error)))
		}
	}
}
