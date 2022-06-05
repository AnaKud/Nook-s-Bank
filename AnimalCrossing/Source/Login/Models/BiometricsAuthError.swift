// BiometricsAuthError.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

public enum BiometricsAuthError: ACError {
	case authError
	case notConntected
	case tooManyAttemp

	public var humanfriendlyTitle: String? {
		return nil
	}

	public var humanfriendlyMessage: String {
		switch self {
		case .authError: return "Internal error. Try again"
		case .notConntected: return "You not using biometrics auth. Please change settings"
		case .tooManyAttemp: return "Too many attemp. Please use passcode."
		}
	}
}
