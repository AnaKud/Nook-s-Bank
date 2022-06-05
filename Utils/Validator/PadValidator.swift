// LoginDataValidator.swift
// Created by Anastasiya Kudasheva on 11.12.2021

public enum PadValidator {
	public static func checkEquality(_ password: String?, _ checkingPassword: String?) -> Bool {
		return password == checkingPassword
	}

	public static func checkLength(_ password: String) -> Bool {
		return password.count == 6
	}

	public static func check(_ password: String) -> Bool {
		let numbers = NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$")
		guard numbers.evaluate(with: password) else { return false }
		return true
	}
}
