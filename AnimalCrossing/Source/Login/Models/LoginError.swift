// LoginError.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

public enum LoginError: ACError {
	case incorrectInfo
	case incorrectPassword
	case notRegister
	case unexpectedError
	case biometricAuthError
	case padError

	public var humanfriendlyTitle: String? {
		return nil
	}

	public var humanfriendlyMessage: String {
		switch self {
		case .incorrectInfo: return "Info is incorrect"
		case .incorrectPassword: return "Password is incorrect"
		case .notRegister: return "You are not registered"
		case .unexpectedError: return "Something wrong"
		case .biometricAuthError: return "Biometric Auth Error"
		case .padError: return "Wrong PadCode"
		}
	}

	public init(_ error: ValidationError) {
		switch error {
		case .padEmpty, .padFormatError, .padLenghtError: self = .padError
		case .passwordEmpty, .passwordFormatError, .passwordLenghtError: self = .incorrectPassword
		case .emailEmpty, .emailFormatError: self = .incorrectInfo
		case .errorOccurent: self = .unexpectedError
		default: self = .unexpectedError
		}
	}
}
