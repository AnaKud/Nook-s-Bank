// Colors.swift
// Created by Anastasiya Kudasheva on 26.03.2022

import UIKit

enum GrayColor {
	case darknestColor
	case darkColor
	case mediumColor
	case lightColor
	case lightestColor
	case mainAccentColor
	case positiveAccentColor
	case negativeAccentColor

	var color: UIColor {
		switch self {
		case .darknestColor: return #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
		case .darkColor: return #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
		case .mediumColor: return #colorLiteral(red: 0.7402947211, green: 0.7402947211, blue: 0.7402947211, alpha: 1)
		case .lightColor: return #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
		case .lightestColor: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		case .mainAccentColor: return #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
		case .positiveAccentColor: return #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
		case .negativeAccentColor: return #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
		}
	}

	var cgColor: CGColor {
		return self.color.cgColor
	}
}

enum GreenColor {
	case darknestColor
	case darkColor
	case mediumColor
	case lightColor
	case lightestColor
	case mainAccentColor
	case positiveAccentColor
	case negativeAccentColor

	var color: UIColor {
		switch self {
		case .darknestColor: return #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
		case .darkColor: return #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
		case .mediumColor: return #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
		case .lightColor: return #colorLiteral(red: 0.8740545511, green: 0.9797915816, blue: 0.5994428396, alpha: 1)
		case .lightestColor: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		case .mainAccentColor: return #colorLiteral(red: 0.2549593747, green: 0.07706225663, blue: 0.4605290294, alpha: 1)
		case .positiveAccentColor: return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
		case .negativeAccentColor: return #colorLiteral(red: 1, green: 0.6509803922, blue: 0.8274509804, alpha: 1)
		}
	}

	var cgColor: CGColor {
		return self.color.cgColor
	}
}

enum PinkColor {
	case darknestColor
	case darkColor
	case mediumColor
	case lightColor
	case lightestColor
	case mainAccentColor
	case positiveAccentColor
	case negativeAccentColor

	var color: UIColor {
		switch self {
		case .darknestColor: return #colorLiteral(red: 0.4215284884, green: 0.355079174, blue: 0.3535149693, alpha: 1)
		case .darkColor: return #colorLiteral(red: 0.6071920991, green: 0.4256311059, blue: 0.4517691731, alpha: 1)
		case .mediumColor: return #colorLiteral(red: 0.7207019925, green: 0.5201186538, blue: 0.5440981984, alpha: 1)
		case .lightColor: return #colorLiteral(red: 0.8784313725, green: 0.7215686275, blue: 0.7450980392, alpha: 1)
		case .lightestColor: return #colorLiteral(red: 0.9543421865, green: 0.9032899737, blue: 0.9021746516, alpha: 1)
		case .mainAccentColor: return #colorLiteral(red: 0.8579692245, green: 0.4339519441, blue: 0.418723017, alpha: 1)
		case .positiveAccentColor: return #colorLiteral(red: 0.5529411765, green: 0.7137254902, blue: 0, alpha: 1)
		case .negativeAccentColor: return #colorLiteral(red: 0.8705882353, green: 0.1921568627, blue: 0.3882352941, alpha: 1)
		}
	}

	var cgColor: CGColor {
		return self.color.cgColor
	}
}

enum BlueColor {
	case darknestColor
	case darkColor
	case mediumColor
	case lightColor
	case lightestColor
	case mainAccentColor
	case positiveAccentColor
	case negativeAccentColor

	var color: UIColor {
		switch self {
		case .darknestColor: return #colorLiteral(red: 0.3294117647, green: 0.1960784314, blue: 0.06274509804, alpha: 1)
		case .darkColor: return #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
		case .mediumColor: return #colorLiteral(red: 0.6705882353, green: 0.8039215686, blue: 0.937254902, alpha: 1)
		case .lightColor: return #colorLiteral(red: 0.9450980392, green: 0.968627451, blue: 0.9882352941, alpha: 1)
		case .lightestColor: return #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 1, alpha: 1)
		case .mainAccentColor: return #colorLiteral(red: 0.6941176471, green: 0.7098039216, blue: 0.9137254902, alpha: 1)
		case .positiveAccentColor: return #colorLiteral(red: 0.7647058824, green: 0.8549019608, blue: 0.7529411765, alpha: 1)
		case .negativeAccentColor: return #colorLiteral(red: 0.937254902, green: 0.6705882353, blue: 0.6784313725, alpha: 1)
		}
	}

	var cgColor: CGColor {
		return self.color.cgColor
	}
}

enum PurpleColor {
	case darknestColor
	case darkColor
	case mediumColor
	case lightColor
	case lightestColor
	case mainAccentColor
	case positiveAccentColor
	case negativeAccentColor

	var color: UIColor {
		switch self {
		case .darknestColor: return #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
		case .darkColor: return #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
		case .mediumColor: return #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
		case .lightColor: return #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
		case .lightestColor: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		case .mainAccentColor: return #colorLiteral(red: 0.7882352941, green: 0.6274509804, blue: 0.862745098, alpha: 1)
		case .positiveAccentColor: return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
		case .negativeAccentColor: return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
		}
	}

	var cgColor: CGColor {
		return self.color.cgColor
	}
}
