// EmailValidator.swift
// Created by Anastasiya Kudasheva on 02.06.2022

import Foundation

public enum EmailValidator {
	public static func checkLength(_ email: String) -> Bool {
		return email.count > 7
	}

	public static func check(_ email: String) -> Bool {
		let pattern = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
		let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
		guard predicate.evaluate(with: email) else { return false }
		return true
	}
}
