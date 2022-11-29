// BankError.swift
// Created by Anastasiya Kudasheva on 01.06.2022

import ACErrors

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
