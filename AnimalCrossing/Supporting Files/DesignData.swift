//
//  DesignData.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 05.07.2021.
//

import UIKit
import SwiftUI

enum AppFont: String {
    case maruLight = "IwataMaruGothicW55-L"
    case maruBold = "IwataMaruGothicW55-D"
    case defaultFont = "system"
    case fink = "FinkHeavy"
}

enum AppImage {
    enum TopBottomImage: String {
        case logTop = "LoginedTop"
        case logBottom = "LoginedBottom"
        case unlogTop = "UnLoginedTop"
        case unlogBottom  = "UnLoginedBottom"
    }
    
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
        case price = "b.circle"
        case count = "multiply.circle"
        case sell = "s.circle"
    }
    enum Prices: String {
        case daisyMae = "DaisyMae"
    }
}

enum TabbarItems {
    struct ImageDefault {
        static let news = "news_tb"
        static let bank = "bank_tb"
        static let turnip = "turnip_tb"
    }
}

struct ColorsSet {
    var cellColorSet: CellColor
    var textfieldColor: TextFieldColor
    var circleViewColor: CircleViewColor
    var ovalButtonColor: OvalButtonColor
    var mainViewColor: MainViewColor
    var activityIndicatorColor: ActivityIndicatorColor
    var bankViewColor: BankViewColor
   // var prophetPricesViewColor: ProphetPricesViewColor
    
    
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
        let titleTextColor: UIColor?
        let itemTextColor: UIColor?
        let expenseLabelColor: UIColor?
        let incomeLabelColor: UIColor?
        
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.backgroundViewColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                self.titleTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.itemTextColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                self.expenseLabelColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
                self.incomeLabelColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
            default:
                self.backgroundViewColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
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
            case .other :
                self.backgroundColor = #colorLiteral(red: 0.8740545511, green: 0.9797915816, blue: 0.5994428396, alpha: 1)
                self.textColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
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
        let borderColor: CGColor?
        let textColor: UIColor?
        let imageColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                self.imageColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
            case .loginScreen:
                self.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
                self.borderColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
                self.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.imageColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
            default:
                self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.borderColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
                self.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.imageColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
            }
        }
    }
    
    struct CircleViewColor {
        let circleColor: UIColor?
        let circleTextColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.circleColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                self.circleTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            case.loginScreen:
                self.circleColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
                self.circleTextColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
            default:
                self.circleColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
                self.circleTextColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
            }
        }
    }
    
    struct OvalButtonColor {
        let buttonColor: UIColor?
        let buttonTextColor: UIColor?
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.buttonColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                self.buttonTextColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
            case.loginScreen:
                self.buttonTextColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
                self.buttonColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
            default:
                self.buttonColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.buttonTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    
    struct CellColor {
        let backgroundViewColor: UIColor?
        let topViewColor: UIColor?
        let accentColor: UIColor?
        let titleTextColor: UIColor?
        let itemTextColor: UIColor?
        
        init(for screenType: ScreenTypes?) {
            switch screenType {
            case .unloggined:
                self.backgroundViewColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                self.topViewColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
                self.accentColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.titleTextColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
                self.itemTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            case .other:
                self.backgroundViewColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.topViewColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
                self.accentColor = #colorLiteral(red: 0.8740545511, green: 0.9797915816, blue: 0.5994428396, alpha: 1)
                self.titleTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.itemTextColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
            default:
                self.backgroundViewColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
                self.topViewColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
                self.accentColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
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

struct GraphColors {
    static let backgroundColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let gradientStart = Color(#colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1))
    static let gradientStop = Color(#colorLiteral(red: 0.8740545511, green: 0.9797915816, blue: 0.5994428396, alpha: 1))
    

}
