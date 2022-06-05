// LogoutError.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

public enum LogoutError: ACError {
	case padDelete
	case forgetPasswordError

	public var humanfriendlyTitle: String? {
		return nil
	}

	public var humanfriendlyMessage: String {
		switch self {
		case .padDelete:
			return "Internal Error. Try to change pad later"
		case .forgetPasswordError:
			return "Internal Error. Try later"
		}
	}
}
