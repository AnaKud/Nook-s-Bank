// errors.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import Foundation
import ACErrors
import SwiftUI

enum ValidationError: ACError {
	case padError
	case passwordError
	case emailError
	case errorOccurent

	var humanfriendlyMessage: String {
		switch self {
		case .padError: return "Pad error, use other pad"
		case .passwordError: return "Password error, use other password"
		case .emailError: return "Email error, use other email"
		case .errorOccurent: return "Error Occurent, try repeat it later"
		}
	}
}

enum BiometricsAuthError: ACError {
	case authError
	case notConntected
	case tooManyAttemp

	var humanfriendlyMessage: String {
		switch self {
		case .authError: return "Internal error. Try again"
		case .notConntected: return "You not using biometrics auth. Please change settings"
		case .tooManyAttemp: return "Too many attemp. Please use passcode."
		}
	}
}

enum LoginValidationResult: Equatable {
	case success(email: String, password: String)
	case error(ValidationError)
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

	var humanfriendlyMessage: String {
		switch self {
		case .padDelete:
			return "Internal Error. Try to change pad later"
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
		case .padError: self = .notRegister
		case .passwordError: self = .incorrectInfo
		case .emailError: self = .incorrectInfo
		case .errorOccurent: self = .unexpectedError
		}
	}
}

enum RegisterError: ACError {
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

public enum ACResult<T, U: ACError> {
	case success(T)
	case failure(U)
}

public protocol ACError {
	var humanfriendlyMessage: String { get }
}

enum InternetError: ACError {
	case noInternet

	var humanfriendlyMessage: String {
		switch self {
		case .noInternet: return "No internet. Check internet connection"
		}
	}
}

enum BankError: ACError {
	case noBankData

	var humanfriendlyMessage: String {
		switch self {
		case .noBankData: return "Can't find bank data"
		}
	}
}
