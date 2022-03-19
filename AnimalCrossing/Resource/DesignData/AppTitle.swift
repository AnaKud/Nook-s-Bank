// AppTitle.swift
// Created by Anastasiya Kudasheva on 05.07.2021.

import Foundation

struct AppTitle {
	static let nookBank = "Bank of Nook"
	static let welcome = "Welcome to"
	static let save = "Save"
	static let cancel = "Cancel"

	struct Login {
		static let emailTF = "Your email"
		static let passwordTF = "Your password"
		static let registerButton = "Register"
		static let loginButton = "Log in"
		static let freeButton = "Continue"
		static let hello = "Hello"
		static let nameMessage = "Enter your name"
	}

	struct News {
		static let controllerTitle = "Nook News"
	}

	struct Bank {
		static let controllerTitle = " Bank of Nook"
		static let currentAccountTitle = "Your current account:"
		static let purchaseHistory = "Purchase History:"
		static let demoTitle = "Demo account:"
		static let demoHistory = "Demo Purchase History:"
		static let newExpense = "Add new expense or income"
	}

	struct Turnip {
		static let controllerTitle = "Turnips' Calculator"
		static let price = "Price"
		static let count = "Count"
		static let sell = "Sell Price"
		static let buyForOval = "P"
		static let buyTitle = "Purchase from Daisy Mae"
		static let sellForOval = "S"
		static let sellTitle = "Sell price in Nook's store"
		static let turnipForOval = "T"
		static let turnipTitle = "Turnips' prices of week"
		static let expense = "Calculate expense"
		static let income = "Calculate income"
		static let turnipPrice = "Prophet prices"
	}

	struct Prophet {
		static let priceForOval = "P"
		static let priceTitle = "Prophet Turnips' Prices"

		static let graphForOval = "G"
		static let graphTitle = "Graph of price changing"
		static let emptyLabel = "Your response was empty. \nNo data to display"
		static let priceMinValue = "Garanted minimum price: "
	}

	struct PassCode {
		static let forgetTitle = "Forget Password?"
	}
}
