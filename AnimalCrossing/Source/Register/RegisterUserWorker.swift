// RegisterUserWorker.swift
// Created by Anastasiya Kudasheva on 22.07.2021.

import Foundation
import ACErrors

class RegisterUserWorker {
	private let fireBaseManager: IUserFBRegistration
	private let userValidator: NewUserValidator
	private let userDefaultManager: UserDefaultManager

	init(fireBaseManager: IUserFBRegistration, userValidator: NewUserValidator) {
		self.fireBaseManager = fireBaseManager
		self.userValidator = userValidator
		self.userDefaultManager = UserDefaultManager()
	}

	func validateNewUser(_ user: NewUserViewModel,
						 completion: @escaping (ACResult<Void, RegisterError>) -> Void) {
		self.userValidator.validateUser(user) { [weak self] validationResult in
			switch validationResult {
			case let .success(user):
				self?.registerUser(user, completion: completion)
			case let .failure(error):
				completion(.failure(.validationError(error)))
			}
		}
	}
}

private extension RegisterUserWorker {
	func registerUser(_ user: NewUserDto, completion: @escaping (ACResult<Void, RegisterError>) -> Void) {
		self.fireBaseManager.register(newUser: user) { result in
			switch result {
			case .success:
				user.padAvailaible ? self.setSimpleLogin(completion: completion) : completion(.success(()))
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}

	func setSimpleLogin(completion: @escaping (ACResult<Void, RegisterError>) -> Void) {
		self.userDefaultManager.setSimpleLogin() ? completion(.success(())) : completion(.failure(.simpleLoginFail))
	}
}
