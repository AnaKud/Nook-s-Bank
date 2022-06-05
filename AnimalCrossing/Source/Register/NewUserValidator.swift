// NewUserValidator.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import Validator

class NewUserValidator {
	func validateUser(_ user: NewUserViewModel,
					  completion: @escaping (ACResult<NewUserDto, ValidationError>) -> Void) {
		self.checkEmail(user, completion: completion)
		self.checkPassword(user, completion: completion)
		self.checkPasscode(user, completion: completion)
	}
}

private extension NewUserValidator {
	func checkEmail(_ user: NewUserViewModel,
					completion: @escaping (ACResult<NewUserDto, ValidationError>) -> Void) {
		guard let email = user.email,
		EmailValidator.checkLength(email) else {
			return completion(.failure(.emailEmpty))
		}
		guard EmailValidator.check(email) else {
			return completion(.failure(.emailFormatError))
		}
	}

	func checkPassword(_ user: NewUserViewModel,
					   completion: @escaping (ACResult<NewUserDto, ValidationError>) -> Void) {
		guard PasswordValidator.checkEquality(user.emailPassword, user.repetedEmailPassword) else {
			return completion(.failure(.passwordNotMatched))
		}
		guard let emailPassword = user.emailPassword else {
			return completion(.failure(.passwordEmpty))
		}
		guard PasswordValidator.checkLength(emailPassword) else {
			return completion(.failure(.passwordLenghtError))
		}
		guard PasswordValidator.check(emailPassword) else {
			return completion(.failure(.passwordFormatError))
		}
	}

	func checkPasscode(_ user: NewUserViewModel,
					   completion: @escaping (ACResult<NewUserDto, ValidationError>) -> Void) {
		if user.padAvailaible {
			guard PadValidator.checkEquality(user.pad, user.repetedPad) else {
				return completion(.failure(.padNotMatched))
			}
			guard let passcode = user.pad else {
				return completion(.failure(.padEmpty))
			}
			guard PadValidator.checkLength(passcode) else {
				return completion(.failure(.padLenghtError))
			}
			guard PadValidator.check(passcode) else {
				return completion(.failure(.padFormatError))
			}
		}
	}
}
