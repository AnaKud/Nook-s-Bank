// ACFont.swift
// Created by Anastasiya Kudasheva on 19.03.2022

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
