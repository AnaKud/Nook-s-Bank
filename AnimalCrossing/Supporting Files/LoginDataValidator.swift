// LoginDataValidator.swift
// Created by Anastasiya Kudasheva on 11.12.2021

import Foundation

class NewUserValidator {
	func validateUser(
		_ user: NewUserViewModel,
		completion: @escaping (NewUserValidationResult) -> Void
	) {
		guard EmailValidator.check(user.email) else {
			return completion(.error(.emailError)) }
		guard PasswordValidator.check(password: user.emailPassword),
			  PasswordValidator.checkEquality(user.emailPassword, user.repetedEmailPassword)
		else {
			return completion(.error(.passwordError)) }
		if user.padAvailaible {
			guard PadValidator.check(password: user.pad),
				  PadValidator.checkEquality(user.pad, user.repetedPad)
			else {
				return completion(.error(.padError)) }
		}
		completion(.success(NewUserDto(user)))
	}
}

enum LoginDataValidator {
	static func check(
		email: String?,
		password: String?,
		completion: @escaping (LoginValidationResult) -> Void
	) {
		guard let email = email,
			  EmailValidator.check(email)
		else {
			return completion(.error(.emailError))
		}
		guard let password = password,
			  PasswordValidator.check(password: password)
		else {
			return completion(.error(.passwordError))
		}
		completion(.success(email: email, password: password))
	}
}

enum EmailValidator {
	static func check(_ email: String?) -> Bool {
		let pattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
		let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
		guard let email = email,
			  email.count > 7,
			  predicate.evaluate(with: email)
		else { return false }
		return true
	}
}

enum PasswordValidator {
	static func checkEquality(_ password: String?, _ checkingPassword: String?) -> Bool {
		return password == checkingPassword
	}

	static func check(password: String?) -> Bool {
		guard let password = password,
			  password.count >= 6,
			  self.checkContainSpecialSymbols(password)
		else { return false }
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

	static func check(password: String?) -> Bool {
		let numbers = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
		guard password?.count == 6,
			  numbers.evaluate(with: password)
		else {
			print(numbers.evaluate(with: password))
			return false }
		return true
	}
}
