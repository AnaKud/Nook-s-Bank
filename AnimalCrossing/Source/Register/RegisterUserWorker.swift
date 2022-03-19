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
						 completion: @escaping (ACVoidResult<RegisterError>) -> Void) {
		self.userValidator.validateUser(user) { [weak self] validationResult in
			if case let .failure(error) = validationResult {
				completion(.failure(.validationError(error)))
			} else {
				self?.registerUser(NewUserDto(user), completion: completion)
			}
		}
	}
}

private extension RegisterUserWorker {
	func registerUser(_ user: NewUserDto, completion: @escaping (ACVoidResult<RegisterError>) -> Void) {
		self.fireBaseManager.register(newUser: user) { result in
			switch result {
			case .success:
				user.padAvailaible ? self.setSimpleLogin(completion: completion) : completion(.success)
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}

	func setSimpleLogin(completion: @escaping (ACVoidResult<RegisterError>) -> Void) {
		self.userDefaultManager.setSimpleLogin() ? completion(.success) : completion(.failure(.simpleLoginFail))
	}
}
