// AddExpenseError.swift
// Created by Anastasiya Kudasheva on 27.03.2022

enum AddExpenseError: ACError {
	case emptyText
	case notInt
	case notSelectExpense

	var humanfriendlyTitle: String? { nil }

	var humanfriendlyMessage: String {
		switch self {
		case .emptyText:
			return "You should enter expense value"
		case .notInt:
			return "You should enter number"
		case .notSelectExpense:
			return "You should select expense type"
		}
	}
}
