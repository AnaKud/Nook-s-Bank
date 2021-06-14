//
//  SupportingFile.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation
import UIKit

enum UserStatus {
    case loggined
    case unloggined
    case loginScreen
}

struct AppContraints {
    static let iphoneWidth = UIWindow().screen.bounds.width
    static let iphoneHeight = UIWindow().screen.bounds.height
    static let navTitle = iphoneHeight > 800 ? 50 : 30
    
    static let minEdge: CGFloat = 5
    static let midEdge: CGFloat = 10
    static let standartEdge: CGFloat = 20
    static let doubleEdge = standartEdge * 2
    
    static let standartCornerRadius: CGFloat = 15
    
    struct Login {
        static let loginVerticalEdge = navTitle * 5
        static let loginMinVerticalEdge = navTitle * 2
        static let loginHorizontelEdge: CGFloat = 50
        static let cornerRadiusTF: CGFloat = 15
        static let imageLeftViewTF: CGFloat = 10
        static let heightTF: CGFloat = 50
        static let heightButtons = heightTF / 1.5
        static let widthButton = AppContraints.iphoneWidth / 3.3
        static let widthLoginButton = AppContraints.iphoneWidth / 3.3 - 15
    }
    struct News {
        static let cellBgEdge: CGFloat = 10
        static let cellContentEdge: CGFloat = 20
        static let cellCornerRadius: CGFloat = 15
        static let dateViewHeight: CGFloat = 44
        static let circleViewSize = 44 - (2 * midEdge)
    }
    struct Bank {
        static let bankAccountViewHeight: CGFloat = 70
        static let plusButtonHeight: CGFloat = 50
        static let collectionCellWidth: CGFloat = (iphoneWidth - 4 * midEdge) / 3.3
        static let collectionCellHeight: CGFloat = collectionCellWidth * 1.5
        static let circleWidth = (collectionCellWidth - (2 * midEdge)) / 2
    }
}

struct AppTitle {
    static let nookBank = "Nook Bank"
    static let welcome = "Welcome to"
    struct Login {
        static let emailTF = "Your email"
        static let passwordTF = "Your password"
        static let registerButton = "Register"
        static let loginButton = "Log in"
        static let freeButton = "Continue"
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
}

enum AppFont: String {
    case maruLight = "IwataMaruGothicW55-L"
    case maruBold = "IwataMaruGothicW55-D"
    case defaultFont = "system"
    case fink = "FinkHeavy"
}

enum AppImage {
    enum Login: String {
        case iconForEmailTF = "person.fill"
        case iconForPasswordTF = "key.fill"
    }
    enum Bank: String {
        case coinLogin = "CoinLog"
        case coinUnLogin = "CoinUnlog"
        case plusLogin = "plusLog"
        case plusUnlogin = "plusUnlog"
    }
}

enum FailureCases: String {
    case fetchError = "Sorry. Can't fetch your data"
    case createError = "Sorry. Can't create your data"
    case saveError = "Sorry. Can't save your data"
    case updateError = "Sorry. Can't update your data"
    case deleteError = "Sorry. Can't delete your data"
    case deleteAllError = "Sorry. Can't delete all your data"
}

enum LoginWarnings: String {
    case incorrectInfo = "Info is incorrect"
    case incorrectEmail = "Email is incorrect"
    case notRegister = "You are not registered"
    case unexpectedError = "Unexpected error"
    case registerError = "Register error"
    case sucssessRegister = "Please login"
}

enum TabbarItems {
    struct ImageDefault {
        static let news = "news"
        static let bank = "bank"
        static let turnip = "turnip"
    }
    struct ImagePressed {
        static let news = "newsP"
        static let bank = "bankP"
        static let turnip = "turnipP"
    }
}

enum AdditionalLink: String {
    case events = "nh/events"
}

enum CellReusibleID: String {
    case news = "newsCell"
    case expense = "expenseCell"
}

//enum Response {
//    case success
//    case failure
//
//}
