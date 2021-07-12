//
//  AppTitle.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 05.07.2021.
//

import Foundation

struct AppTitle {
    static let nookBank = "Nook Bank"
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
        static let controllerTitle = "Nook Bank"
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
}

enum FailureCases: String {
    case fetchError = "Sorry. Can't fetch your data"
    case createError = "Sorry. Can't create your data"
    case saveError = "Sorry. Can't save your data"
    case updateError = "Sorry. Can't update your data"
    case deleteError = "Sorry. Can't delete your data"
    case deleteAllError = "Sorry. Can't delete all your data"
    case turnipPriceError = "You should add Turnip price to calculate it"
}

enum LoginWarnings: String {
    case incorrectInfo = "Info is incorrect"
    case incorrectEmail = "Email is incorrect"
    case notRegister = "You are not registered"
    case unexpectedError = "Something wrong"
    case registerError = "Register error"
    case sucssessRegister = "Please login"
}