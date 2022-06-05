// RegisterError.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

enum RegisterError: ACError {
	case validationError(ValidationError)
	case databaseFail
	case simpleLoginFail

	var humanfriendlyMessage: String {
		switch self {
		case .databaseFail: return "DB access denied. Try create new user later"
		case .simpleLoginFail: return "Can't set simple pad. Try change pad code in user settings"
		case .validationError(let validationError): return validationError.humanfriendlyMessage
		}
	}
}
