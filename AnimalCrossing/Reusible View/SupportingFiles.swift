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
}

struct AppContraints {
    static let iphoneWidth = UIWindow().screen.bounds.width
    static let iphoneHeight = UIWindow().screen.bounds.height
    static let navTitle = iphoneHeight > 800 ? 50 : 30
    
    static let minEdge: CGFloat = 5
    
    struct Login {
        static let loginVerticalEdge = navTitle * 3
        static let loginHorizontelEdge: CGFloat = 50
        
        static let cornerRadiusTF: CGFloat = 15
        static let imageLeftViewTF: CGFloat = 10
        static let heightTF: CGFloat = 50
        static let heightButtons = heightTF / 1.5
        static let widthButton = AppContraints.iphoneWidth - CGFloat(loginVerticalEdge * 3)
    }
    
    
    static let standartEdge: CGFloat = 20
    static let doubleEdge = standartEdge * 2
    
    
    
}

struct AppTitle {
    struct Login {
        static let userNameTF = "Your email"
        static let passwordTF = "Your password"
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
