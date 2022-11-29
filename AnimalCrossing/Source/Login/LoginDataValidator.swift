// LoginDataValidator.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import Validator

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
