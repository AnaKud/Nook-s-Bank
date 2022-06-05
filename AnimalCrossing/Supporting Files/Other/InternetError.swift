// InternetError.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

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

