// PasswordValidator.swift
// Created by Anastasiya Kudasheva on 02.06.2022

public enum PasswordValidator {
	public static func checkEquality(_ password: String?, _ checkingPassword: String?) -> Bool {
		return password == checkingPassword
	}

	public static func checkLength(_ password: String) -> Bool {
		return password.count >= 6
	}

	public static func check(_ password: String) -> Bool {
		guard self.checkContainSpecialSymbols(password) else { return false }
		return true
	}

	private static func checkContainSpecialSymbols(_ password: String) -> Bool {
		let upperCasedCharacters = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
		let numbers = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
		let specialSymbols = NSPredicate(format: "SELF MATCHES %@", ".*[!&^%$#@()/]+.*")
		guard upperCasedCharacters.evaluate(with: password),
			  numbers.evaluate(with: password),
			  specialSymbols.evaluate(with: password)
		else { return false }
		return true
	}
}

