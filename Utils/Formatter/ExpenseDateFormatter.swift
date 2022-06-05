// ExpenseDateFormatter.swift
// Created by Anastasiya Kudasheva on 12.03.2022

import Foundation

public enum ExpenseDateFormatter {
	static func convert(_ date: Double?) -> String {
		guard let date = date else { return "" }
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "HH:mm \n dd MMM yyyy"
		return dateFormatter.string(from: Date(timeIntervalSince1970: date))
	}
}
