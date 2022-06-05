// Results.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

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
