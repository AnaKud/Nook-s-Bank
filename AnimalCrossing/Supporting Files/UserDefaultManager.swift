// UserDefaultManager.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import Foundation

enum LoginType: String {
	case simple
	case full

	init() {
		if let value = UserDefaults.standard.value(forKey: "simpleLogin") as? Bool,
		   value == true {
			self = .simple
		} else {
			self = .full
		}
	}
}

class UserDefaultManager {
	private let simpleLoginKey = "simpleLogin"

	init() { }

	func setSimpleLogin() -> Bool {
		UserDefaults.standard.setValue(true, forKey: self.simpleLoginKey)
		return self.checkUDValue(for: self.simpleLoginKey)
	}

	func removeSimpleLogin() -> Bool {
		UserDefaults.standard.setValue(false, forKey: self.simpleLoginKey)
		return !self.checkUDValue(for: self.simpleLoginKey)
	}
}

private extension UserDefaultManager {
	func checkUDValue(for key: String) -> Bool {
		if let value = UserDefaults.standard.value(forKey: key) as? Bool {
			return value
		} else {
			return false
		}
	}
}
