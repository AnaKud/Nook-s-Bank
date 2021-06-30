//
//  SupportingFile.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation
import UIKit

enum ScreenTypes {
    case loggined
    case unloggined
    case loginScreen
}

struct AppContraints {
    static let iphoneWidth = UIWindow().screen.bounds.width
    static let iphoneHeight = UIWindow().screen.bounds.height
    static let navTitle: CGFloat = iphoneHeight > 800 ? 50 : 30
    static let navAndTabHeight: CGFloat = iphoneHeight > 800 ? 110 : 80
    
    static let minEdge: CGFloat = 5
    static let midEdge: CGFloat = 10
    static let standartEdge: CGFloat = 20
    static let doubleEdge = standartEdge * 2
    
    static let standartCornerRadius: CGFloat = 15
    
    struct Login {
        static let loginVerticalEdge = navTitle * 4
        static let loginMinVerticalEdge = navTitle * 2
        static let loginHorizontelEdge: CGFloat = 50
        static let cornerRadiusTF: CGFloat = 15
        static let imageLeftViewTF: CGFloat = 10
        static let heightTF: CGFloat = 50
        static let heightButtons = heightTF / 1.5
        static let widthButton = AppContraints.iphoneWidth / 3.3
        static let widthLoginButton = AppContraints.iphoneWidth / 3.3 - 15
    }
    struct CellSizes {
        static let cellBgEdge: CGFloat = 10
        static let cellMaxEdge: CGFloat = 40
        static let widthOffset: CGFloat = -2 * cellBgEdge
        static let cellContentEdge: CGFloat = 20
        static let cellCornerRadius: CGFloat = 15
        static let cellCornerMinRadius: CGFloat = 7
        static let topViewHeight: CGFloat = 44
        static let circleViewSize = 44 - (2 * midEdge)
    }
    struct Bank {
        static let bankAccountViewHeight: CGFloat = 70
        static let plusButtonHeight: CGFloat = 50
        static let collectionCellWidth: CGFloat = (iphoneWidth - 4 * midEdge) / 4.3
        static let collectionCellHeight: CGFloat = collectionCellWidth * 1.54
        static let imageCollectionViewEdge: CGFloat = 10
        static let imageCollectionViewSize: CGFloat = collectionCellWidth - 2 * imageCollectionViewEdge
        static let circleWidth = (collectionCellWidth - (2 * midEdge)) / 2
    }
    struct Turnip {
        static let heightTF: CGFloat = 35
        static let cornerRadius: CGFloat  = 5
        
        static let columnWidth: CGFloat = (AppContraints.iphoneWidth - 2 * AppContraints.midEdge) / 3
        
        
        static let morningEveningWidth = columnWidth - 40
        static let morningEveningHeigth = morningEveningWidth / 2
        
        static let imageEdge: CGFloat = 5
        static let imageWidthHeight = morningEveningHeigth - (imageEdge * 2)
        
        
    }
}

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
        static let buyForOval = "P"
        static let buyTitle = "Purchase from Daisy Mae"
        static let sellForOval = "S"
        static let sellTitle = "Sell price in Nook's store"
        static let turnipForOval = "T"
        static let turnipTitle = "Turnips' prices of week"
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
    enum Turnip: String {
        case morning = "sun.max"
        case evening = "moon.stars"
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
    case unexpectedError = "Something wrong"
    case registerError = "Register error"
    case sucssessRegister = "Please login"
}

enum TabbarItems {
    struct ImageDefault {
        static let news = "news"
        static let bank = "bank"
        static let turnip = "turnip"
    }
}

enum AdditionalLink: String {
    case events = "nh/events"
}

enum CellReusibleID: String {
    case news = "newsCell"
    case expense = "expenseCell"
}

struct ColorsSet {
    var cellColorSet: CellColor
    var textfieldColor: TextFieldColor
    var circleViewColor: CircleViewColor
    var ovalButtonColor: OvalButtonColor
    var mainViewColor: MainViewColor
    var activityIndicatorColor: ActivityIndicatorColor
    var bankViewColor: BankViewColor
    
    init(for screenType: ScreenTypes?){
        self.cellColorSet = CellColor(for: screenType)
        self.textfieldColor = TextFieldColor(for: screenType)
        self.circleViewColor = CircleViewColor(for: screenType)
        self.ovalButtonColor = OvalButtonColor(for: screenType)
        self.mainViewColor = MainViewColor(for: screenType)
        self.activityIndicatorColor = ActivityIndicatorColor(for: screenType)
        self.bankViewColor = BankViewColor(for: screenType)

    }
    
    
    
    struct BankViewColor {
        let backgroundViewColor: UIColor?
        //let topViewColor: UIColor?
        let titleTextColor: UIColor?
        let itemTextColor: UIColor?
        let expenseLabelColor: UIColor?
        let incomeLabelColor: UIColor?
        
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.backgroundViewColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                //self.topViewColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                self.titleTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.itemTextColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                self.expenseLabelColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
                self.incomeLabelColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
            default:
                self.backgroundViewColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
               // self.topViewColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.titleTextColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.itemTextColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
                self.expenseLabelColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                self.incomeLabelColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }
        }
    }

    struct ActivityIndicatorColor {
        let activityColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.activityColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            default:
                self.activityColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
            }
        }
    }
    
    struct MainViewColor {
        let backgroundColor:  UIColor?
        let textColor: UIColor?
        let navigationItemColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.navigationItemColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            default:
                self.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
                self.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.navigationItemColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            }
        }
    }

    struct TextFieldColor {
        let backgroundColor: UIColor?
        let textColor: UIColor?
        let imageColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                self.imageColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                
            case .loginScreen:
                self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
                self.textColor = #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
                self.imageColor = #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
            default:
                self.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
                self.textColor = #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
                self.imageColor = #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
            }
        }
    }
    
    struct CircleViewColor {
        let circleColor: UIColor?
        let circleTextColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.circleColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.circleTextColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                
            default:
                self.circleColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
                self.circleTextColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)

            }
        }
    }
    
    struct OvalButtonColor {
        let buttonColor: UIColor?
        let buttonTextColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.buttonTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.buttonColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                
            default:
                self.buttonTextColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
                self.buttonColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)

            }
        }
    }
    
    struct CellColor {
        let backgroundViewColor: UIColor?
        let topViewColor: UIColor?
        let titleTextColor: UIColor?
        let itemTextColor: UIColor?
        
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.backgroundViewColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                self.topViewColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                self.titleTextColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                self.itemTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            default:
                self.backgroundViewColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
                self.topViewColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.titleTextColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
                self.itemTextColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
            }
        }
    }
    
}

struct TapBarColor {
    let selectedColor: UIColor?
    let unselectedColor: UIColor?
    init(for screenType: ScreenTypes?) {
        switch screenType {
        case .unloggined:
            self.selectedColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            self.unselectedColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        default:
            self.selectedColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
            self.unselectedColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
        }
    }
}
