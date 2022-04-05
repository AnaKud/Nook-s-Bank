// errors.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import Foundation
import ACErrors
import SwiftUI

enum ValidationError: ACError {
	case padLenghtError
	case padFormatError
	case padNotMatched
	case padEmpty
	case passwordLenghtError
	case passwordFormatError
	case passwordNotMatched
	case passwordEmpty
	case emailFormatError
	case emailEmpty
	case errorOccurent

	var humanfriendlyTitle: String? {
		switch self {
		case .padLenghtError,
				.padFormatError,
				.padNotMatched,
				.padEmpty:
			return "Passcode error"
		case .passwordLenghtError,
				.passwordFormatError,
				.passwordEmpty,
				.passwordNotMatched:
			return "Password error"
		case .emailFormatError,
				.emailEmpty:
			return "Email error"
		case .errorOccurent:
			return "Error occurent"
		}
	}

	var humanfriendlyMessage: String {
		switch self {
		case .padLenghtError:
			return "Passcode should be 6 number lenght"
		case .padFormatError:
			return "Passcode should contain only numbers"
		case .padNotMatched:
			return "Passcodes not matchced. Check it"
		case .padEmpty:
			return "You did not provide a passcode"
		case .passwordLenghtError:
			return "Password should contain 6 character"
		case .passwordFormatError:
			return "Password should contain special symbol, uppercase and lowercase characters, numbers"
		case .passwordNotMatched:
			return "Passwords not matchced. Check it"
		case .passwordEmpty:
			return "You did not provide a password"
		case .emailFormatError:
			return "Email is in incorrect format"
		case .emailEmpty:
			return "You did not provide an email"
		case .errorOccurent:
			return "Try repeat later"
		}
	}
}

enum BiometricsAuthError: ACError {
	case authError
	case notConntected
	case tooManyAttemp

	var humanfriendlyTitle: String? {
		return nil
	}

	var humanfriendlyMessage: String {
		switch self {
		case .authError: return "Internal error. Try again"
		case .notConntected: return "You not using biometrics auth. Please change settings"
		case .tooManyAttemp: return "Too many attemp. Please use passcode."
		}
	}
}

struct ValidatedUserData {
	let email: String
	let password: String
}

extension ValidatedUserData: Equatable { }

enum LoginValidationResult: Equatable {
	case success(email: String, password: String)
	case failure(ValidationError)
}

enum NewUserValidationResult: Equatable {
	case success(NewUserDto)
	case error(ValidationError)

	static func == (lhs: NewUserValidationResult, rhs: NewUserValidationResult) -> Bool {
		switch (lhs, rhs) {
		case (let .success(lhsUser), let .success(rhsUser)): // swiftlint:disable:this pattern_matching_keywords
			return lhsUser == rhsUser
		case (let .error(lhsError), let .error(rhsError)): // swiftlint:disable:this pattern_matching_keywords
			return lhsError == rhsError
		default: return false
		}
	}
}

enum FailureCases: String {
	case fetchError = "Sorry. Can't fetch your data"
	case createError = "Sorry. Can't create your data"
	case saveError = "Sorry. Can't save your data"
	case updateError = "Sorry. Can't update your data"
	case deleteError = "Sorry. Can't delete your data"
	case deleteAllError = "Sorry. Can't delete all your data"
	case turnipPriceError = "You should add Turnip price to calculate it"
}

enum LoginResult {
	case success(LoginType)
	case error(LoginError)
}

enum LogoutError: ACError {
	case padDelete
	case forgetPasswordError

	var humanfriendlyTitle: String? {
		return nil
	}

	var humanfriendlyMessage: String {
		switch self {
		case .padDelete:
			return "Internal Error. Try to change pad later"
		case .forgetPasswordError:
			return "Internal Error. Try later"
		}
	}
}

enum LoginError: ACError {
	case incorrectInfo
	case incorrectPassword
	case notRegister
	case unexpectedError
	case biometricAuthError
	case padError

	var humanfriendlyTitle: String? {
		return nil
	}

	var humanfriendlyMessage: String {
		switch self {
		case .incorrectInfo: return "Info is incorrect"
		case .incorrectPassword: return "Password is incorrect"
		case .notRegister: return "You are not registered"
		case .unexpectedError: return "Something wrong"
		case .biometricAuthError: return "Biometric Auth Error"
		case .padError: return "Wrong PadCode"
		}
	}

	init(_ error: ValidationError) {
		switch error {
		case .padEmpty, .padFormatError, .padLenghtError: self = .padError
		case .passwordEmpty, .passwordFormatError, .passwordLenghtError: self = .incorrectPassword
		case .emailEmpty, .emailFormatError: self = .incorrectInfo
		case .errorOccurent: self = .unexpectedError
		default: self = .unexpectedError
		}
	}
}

enum RegisterError: ACError {
	var humanfriendlyTitle: String? {
		return nil
	}

	var humanfriendlyMessage: String {
		switch self {
		case .databaseFail: return "DB access denied. Try create new user later"
		case .simpleLoginFail: return "Can't set simple pad. Try change pad code in user settings"
		case .validationError(let validationError): return validationError.humanfriendlyMessage
		}
	}
	case validationError(ValidationError)
	case databaseFail
	case simpleLoginFail
}

public enum ACVoidResult<U: ACError> {
	case success
	case failure(U)
}

extension ACVoidResult: Equatable {
	public static func == (lhs: ACVoidResult<U>, rhs: ACVoidResult<U>) -> Bool {
		switch (lhs, rhs) {
		case (.success, .success):
			return true
		case let (.failure(lhsValue), .failure(rhsValue)):
			return lhsValue.humanfriendlyTitle == rhsValue.humanfriendlyTitle
			&& lhsValue.humanfriendlyMessage == rhsValue.humanfriendlyMessage
		default:
			return false
		}
	}
}

public enum ACResult<T: Equatable, U: ACError> {
	case success(T)
	case failure(U)
}

extension ACResult: Equatable {
	public static func == (lhs: ACResult<T, U>, rhs: ACResult<T, U>) -> Bool {
		switch (lhs, rhs) {
		case let (.success(lhsValue), .success(rhsValue)):
			return lhsValue == rhsValue
		case let (.failure(lhsValue), .failure(rhsValue)):
			return lhsValue.humanfriendlyTitle == rhsValue.humanfriendlyTitle
			&& lhsValue.humanfriendlyMessage == rhsValue.humanfriendlyMessage
		default:
			return false
		}
	}
}

public protocol ACError {
	var humanfriendlyTitle: String? { get }
	var humanfriendlyMessage: String { get }
}

enum InternetError: ACError {
	case noInternet

	var humanfriendlyTitle: String? {
		return nil
	}

	var humanfriendlyMessage: String {
		switch self {
		case .noInternet: return "No internet. Check internet connection"
		}
	}
}

enum BankError: ACError {
	case noBankData

	var humanfriendlyTitle: String? {
		return nil
	}

	var humanfriendlyMessage: String {
		switch self {
		case .noBankData: return "Can't find bank data"
		}
	}
}
