// LoginDataValidator.swift
// Created by Anastasiya Kudasheva on 11.12.2021

import Foundation

class NewUserValidator {
	func validateUser(_ user: NewUserViewModel,
					  completion: @escaping (ACResult<NewUserDto, ValidationError>) -> Void) {
		self.checkEmail(user, completion: completion)
		self.checkPassword(user, completion: completion)
		self.checkPasscode(user, completion: completion)
		completion(.success(NewUserDto(user)))
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

enum LoginDataValidator {
	static func check(email: String?,
					  password: String?,
					  completion: @escaping (ACResult<ValidatedUserData, ValidationError>) -> Void) {
		guard let email = email,
		EmailValidator.checkLength(email) else {
			return completion(.failure(.emailEmpty))
		}
		guard EmailValidator.check(email) else {
			return completion(.failure(.emailFormatError))
		}
		guard let password = password else {
			return completion(.failure(.passwordEmpty))
		}
		guard PasswordValidator.checkLength(password) else {
			return completion(.failure(.passwordLenghtError))
		}
		guard PasswordValidator.check(password) else {
			return completion(.failure(.passwordFormatError))
		}
		completion(.success(ValidatedUserData(email: email, password: password)))
	}

	static func check(email: String?,
					  completion: @escaping (ACResult<String, ValidationError>) -> Void) {
		guard let email = email,
		EmailValidator.checkLength(email) else {
			return completion(.failure(.emailEmpty))
		}
		guard EmailValidator.check(email) else {
			return completion(.failure(.emailFormatError))
		}
		completion(.success(email))
	}
}

enum EmailValidator {
	static func checkLength(_ email: String) -> Bool {
		return email.count > 7
	}

	static func check(_ email: String) -> Bool {
		let pattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
		let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
		guard predicate.evaluate(with: email)
		else { return false }
		return true
	}
}

enum PasswordValidator {
	static func checkEquality(_ password: String?, _ checkingPassword: String?) -> Bool {
		return password == checkingPassword
	}

	static func checkLength(_ password: String) -> Bool {
		return password.count >= 6
	}

	static func check(_ password: String) -> Bool {
		guard self.checkContainSpecialSymbols(password) else { return false }
		return true
	}

	private static func checkContainSpecialSymbols(_ password: String) -> Bool {
		let upperCasedCharacters = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
		let numbers = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
		let specialSymbols = NSPredicate(format: "SELF MATCHES %@", ".*[!&^%$#@()/]+.*")
		guard upperCasedCharacters.evaluate(with: password),
			  numbers.evaluate(with: password),
			  specialSymbols.evaluate(with: password)
		else { return false }
		return true
	}
}

enum PadValidator {
	static func checkEquality(_ password: String?, _ checkingPassword: String?) -> Bool {
		return password == checkingPassword
	}

	static func checkLength(_ password: String) -> Bool {
		return password.count >= 6
	}

	static func check(_ password: String) -> Bool {
		let numbers = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
		guard numbers.evaluate(with: password) else { return false }
		return true
	}
}
