// ValidationError.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

public enum ValidationError: ACError {
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

	public var humanfriendlyTitle: String? {
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

	public var humanfriendlyMessage: String {
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
