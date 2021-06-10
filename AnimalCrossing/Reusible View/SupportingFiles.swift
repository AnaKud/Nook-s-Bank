//
//  SupportingFiles.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation
import UIKit
import Localize_Swift

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
    
    struct Login {
        static let loginVerticalEdge = navTitle * 4
        static let loginHorizontelEdge: CGFloat = 50
        
        static let cornerRadiusTF: CGFloat = 15
        static let imageLeftViewTF: CGFloat = 10
        static let heightTF: CGFloat = 50
        static let heightButtons = heightTF / 1.5
        static let widthButton = AppContraints.iphoneWidth / 3.3
        static let widthLoginButton = AppContraints.iphoneWidth / 3.3 - 15
    }
    
    
    static let standartEdge: CGFloat = 20
    static let doubleEdge = standartEdge * 2
    
    
    
}

struct AppTitle {
    struct Login {
        static let userNameTF = "Your email"
        static let passwordTF = "Your password"
        static let registerButton = "Register"
        static let loginButton = "Log in"
        static let freeButton = "Continue"
        
    }
    static let nookBank = "Nook Bank"
    static let welcome = "Welcome to"
    
    
}

enum AppFont: String {
    case maruLight = "IwataMaruGothicW55-L"
    case maruBold = "IwataMaruGothicW55-D"
    case defaultFont = "system"
    case fink = "FinkHeavy"
}

enum AppImage {
    
    
    enum Login: String {

        
        case iconForUserTF = "person.fill"
        case iconForPasswordTF = "key.fill"
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
