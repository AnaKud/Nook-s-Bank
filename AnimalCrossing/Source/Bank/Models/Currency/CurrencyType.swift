// CurrencyType.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

enum CurrencyType: IFirKeys {
	case poki
	case miles
	case bells
	case loan

	var key: NSString {
		switch self {
		case .poki: return "poki"
		case .miles: return "miles"
		case .bells: return "bells"
		case .loan: return "loan"
		}
	}

	var name: String {
		switch self {
		case .poki: return "poki"
		case .miles: return "miles"
		case .bells: return "bells"
		case .loan: return "loan"
		}
	}

	init(_ name: String?) {
		switch name {
		case "poki": self = .poki
		case "miles": self = .miles
		case "loan": self = .loan
		default: self = .bells
		}
	}
}
