// DesignData.swift
// Created by Anastasiya Kudasheva on 05.07.2021.

import SwiftUI
import UIKit

enum ACFontName: String {
	case maruLight = "IwataMaruGothicW55-L"
	case maruBold = "IwataMaruGothicW55-D"
	case defaultFont = "system"
	case fink = "FinkHeavy"
}

enum ACFont {
	case loginButtonFont
	case welcomeFont
	case appNameFont
	case defaultLightFont
	case defaultBoldFont
	case padFont
	case controllerTitleFont
	case newsLightFont
	case newsBoldFont
	case topViewFont
	case bankAccountFont
	case bankValueFont
	case bankDateFont
	case weekViewFont
	case priceFont
	case purchaseFont

	var font: UIFont? {
		if AppContraints.iphoneHeight > 800 {
			switch self {
			case .loginButtonFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 16)
			case .welcomeFont:
				return UIFont(name: ACFontName.fink.rawValue, size: 36)
			case .appNameFont:
				return UIFont(name: ACFontName.fink.rawValue, size: 40)
			case .defaultLightFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 20)
			case .defaultBoldFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 20)
			case .padFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 50)
			case .controllerTitleFont:
				return UIFont(name: ACFontName.fink.rawValue, size: 40)
			case .newsLightFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 20)
			case .newsBoldFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 20)
			case .topViewFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 20)
			case .bankAccountFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 20)
			case .bankValueFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 14)
			case .bankDateFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 10)
			case .weekViewFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 14)
			case .priceFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 16)
			case .purchaseFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 18)
			}
		} else {
			switch self {
			case .loginButtonFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 13)
			case .welcomeFont:
				return UIFont(name: ACFontName.fink.rawValue, size: 32)
			case .appNameFont:
				return UIFont(name: ACFontName.fink.rawValue, size: 36)
			case .defaultLightFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 16)
			case .defaultBoldFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 16)
			case .padFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 32)
			case .controllerTitleFont:
				return UIFont(name: ACFontName.fink.rawValue, size: 30)
			case .newsLightFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 18)
			case .newsBoldFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 18)
			case .topViewFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 16)
			case .bankAccountFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 18)
			case .bankValueFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 12)
			case .bankDateFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 8)
			case .weekViewFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 10)
			case .priceFont:
				return UIFont(name: ACFontName.maruLight.rawValue, size: 14)
			case .purchaseFont:
				return UIFont(name: ACFontName.maruBold.rawValue, size: 16)
			}
		}
	}
}

enum AppImage {
	enum TopBottomImage: String {
		case logTop = "LoginedTop"
		case logBottom = "LoginedBottom"
		case unlogTop = "UnLoginedTop"
		case unlogBottom = "UnLoginedBottom"

		var image: UIImage? {
			UIImage(named: self.rawValue)
		}
	}

	enum UserSettings: String {
		case pensil

		var image: UIImage? {
			UIImage(named: self.rawValue)
		}
	}

	enum Login: String {
		case back = "chevron.backward"
		case iconForEmailTF = "person.fill"
		case iconForPasswordTF = "key.fill"

		var image: UIImage? {
			return UIImage(systemName: self.rawValue)
		}
	}

	enum Bank: String {
		case coinLogin = "CoinLog"
		case coinUnLogin = "CoinUnlog"
		case plusLogin = "plusLog"
		case plusUnlogin = "plusUnlog"

		var image: UIImage? {
			UIImage(named: self.rawValue)
		}
	}

	enum Turnip: String {
		case morning = "sun.max"
		case evening = "moon.stars"
		case price = "b.circle"
		case count = "multiply.circle"
		case sell = "s.circle"

		var image: UIImage? {
			UIImage(systemName: self.rawValue)
		}
	}

	enum Prices: String {
		case daisyMae = "DaisyMae"

		var image: UIImage? {
			UIImage(named: self.rawValue)
		}
	}

	enum PinPad {
		case backspace
		case person
		case authImage

		var imageName: String {
			switch self {
			case .backspace:
				return "chevron.backward.square"
			case .person:
				return "person.fill.questionmark"
			case .authImage:
				let biometricType = Biometric.biometricType
				switch biometricType {
				case .face:
					return "faceid"
				case .touch:
					return "touchid"
				default:
					return "circle"
				}
			}
		}

		var image: UIImage? {
			UIImage(named: self.imageName)
		}
	}

	enum AvatarIcon: String, CaseIterable {
		case blathers = "Blathers"
		case celeste = "Celeste"
		case daisyMae = "DaisyMae"
		case isabelle = "Isabelle"
		case kkSlider = "KKSlider"
		case orville = "Orville"
		case redd = "Redd"
		case timmyNook = "TimmyNook"
		case tommyNook = "TommyNook"
		case tomNook = "TomNook"
		case wilbur = "Wilbur"
		case wisp = "Wisp"

		init?(index: Int) {
			self = AppImage.AvatarIcon.allCases[index]
		}

		static var randomImage: UIImage? {
			let item = self.allCases.randomElement() ?? .tomNook
			return UIImage(named: item.rawValue)
		}

		static var count: Int {
			return self.allCases.count
		}

		var image: UIImage? {
			UIImage(named: self.rawValue)
		}
	}

	enum Settings: String {
		case plus = "GreenPlus"

		var image: UIImage? {
			UIImage(named: self.rawValue)
		}
	}
}

enum TabbarItems {
	struct ImageDefault {
		static let news = "news_tb"
		static let bank = "bank_tb"
		static let turnip = "turnip_tb"
	}
}
