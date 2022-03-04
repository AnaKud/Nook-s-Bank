// ColorSet.swift
// Created by Anastasiya Kudasheva on 04.12.2021

import SwiftUI
import UIKit

struct ColorSet {
	var cellColorSet: CellColor
	var textfieldColor: TextFieldColor
	var circleViewColor: CircleViewColor
	var ovalButtonColor: OvalButtonColor
	var mainViewColor: MainViewColor
	var activityIndicatorColor: ActivityIndicatorColor
	var bankViewColor: BankViewColor
	var passCodeColor: PassCodeViewColor
	var segmentedControlColor: SegmentedControlColor
	var switchColor: SwitchColor

	init(for screenType: ScreenTypes?) {
		self.cellColorSet = CellColor(for: screenType)
		self.textfieldColor = TextFieldColor(for: screenType)
		self.circleViewColor = CircleViewColor(for: screenType ?? .other)
		self.ovalButtonColor = OvalButtonColor(for: screenType)
		self.mainViewColor = MainViewColor(for: screenType)
		self.activityIndicatorColor = ActivityIndicatorColor(for: screenType)
		self.bankViewColor = BankViewColor(for: screenType)
		self.passCodeColor = PassCodeViewColor()
		self.segmentedControlColor = SegmentedControlColor(for: screenType)
		self.switchColor = SwitchColor(for: screenType)
	}
}

extension ColorSet {
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
}

extension ColorSet {
	struct SwitchColor {
		let borderColor: CGColor?
		let backgroundColor: UIColor?
		let thumbTintColor: UIColor?
		let onTintColor: UIColor?

		init(for screenType: ScreenTypes?) {
			switch screenType {
			case .unloggined:
				self.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
				self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				self.thumbTintColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
				self.onTintColor = #colorLiteral(red: 0.7164476514, green: 0.7121906877, blue: 0.7197213769, alpha: 1)
			case .other:
				self.borderColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
				self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				self.thumbTintColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
				self.onTintColor = #colorLiteral(red: 0.8740545511, green: 0.9797915816, blue: 0.5994428396, alpha: 1)
			default:
				self.borderColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				self.thumbTintColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
				self.onTintColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
			}
		}
	}
}

extension ColorSet {
	struct SegmentedControlColor {
		let borderColor: CGColor?
		let backgroundColor: UIColor?
		let selectedItemBgColor: UIColor?
		let textColor: UIColor?
		let selectedTextColor: UIColor?

		init(for screenType: ScreenTypes?) {
			switch screenType {
			case .unloggined:
				self.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
				self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				self.selectedItemBgColor = #colorLiteral(red: 0.7164476514, green: 0.7121906877, blue: 0.7197213769, alpha: 1)
				self.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
				self.selectedTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
			case .other:
				self.borderColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
				self.backgroundColor = #colorLiteral(red: 0.8740545511, green: 0.9797915816, blue: 0.5994428396, alpha: 1)
				self.selectedItemBgColor = #colorLiteral(red: 0.7349590659, green: 0.8215679526, blue: 0.5087055564, alpha: 1)
				self.textColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
				self.selectedTextColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
			default:
				self.borderColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
				self.selectedItemBgColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
				self.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.selectedTextColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
			}
		}
	}
}

extension ColorSet {
	struct ActivityIndicatorColor {
		let activityColor: UIColor?
		init(for screenType: ScreenTypes?) {
			switch screenType {
			case .unloggined:
				self.activityColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
			case .other:
				self.activityColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
			default:
				self.activityColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
			}
		}
	}
}

extension ColorSet {
	struct PassCodeViewColor {
		let backgroundColor: UIColor?
		let textColor: UIColor?
		let pinColor: UIColor?
		let pinBorderColor: CGColor?
		let buttonBorderColor: CGColor?
		let buttonTappedBgColor: CGColor?
		let buttonBgColor: CGColor?
		let buttonNumberColor: UIColor?

		init(for screenType: ScreenTypes = .other) {
			switch screenType {
			case .other:
				self.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.9803921569, blue: 0.6, alpha: 1)
				self.textColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
				self.pinColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
				self.pinBorderColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
				self.buttonBorderColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
				self.buttonTappedBgColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 0.1942777318)
				self.buttonBgColor = #colorLiteral(red: 0.8745098039, green: 0.9803921569, blue: 0.6, alpha: 1)
				self.buttonNumberColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
			default:
				self.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.9803921569, blue: 0.6, alpha: 1)
				self.textColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
				self.pinColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
				self.pinBorderColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
				self.buttonBorderColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
				self.buttonTappedBgColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 0.1942777318)
				self.buttonBgColor = #colorLiteral(red: 0.8745098039, green: 0.9803921569, blue: 0.6, alpha: 1)
				self.buttonNumberColor = #colorLiteral(red: 0.1948110163, green: 0.388961494, blue: 0.01023789216, alpha: 1)
			}
		}
	}
}

extension ColorSet {
	struct MainViewColor {
		let backgroundColor: UIColor?
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
				self.textColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
				self.navigationItemColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
			default:
				self.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
				self.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.navigationItemColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
			}
		}
	}
}

extension ColorSet {
	struct TextFieldColor {
		let backgroundColor: UIColor?
		let uneditableBackgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
			case .other:
				self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				self.borderColor = #colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1)
				self.textColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
				self.imageColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
			default:
				self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				self.borderColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
				self.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.imageColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
			}
		}
	}
}

extension ColorSet {
	struct CircleViewColor {
		let circleColor: UIColor?
		let circleTextColor: UIColor?
		init(for screenType: ScreenTypes) {
			switch screenType {
			case .unloggined:
				self.circleColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
				self.circleTextColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)

			case .loggined:
				self.circleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				self.circleTextColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)

			case .loginScreen:
				self.circleColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
				self.circleTextColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)

			case .other:
				self.circleColor = #colorLiteral(red: 0.8745098039, green: 0.9450980392, blue: 0.7333333333, alpha: 1)
				self.circleTextColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
			}
		}
	}
}

extension ColorSet {
	struct OvalButtonColor {
		let buttonColor: UIColor?
		let buttonTextColor: UIColor?
		init(for screenType: ScreenTypes?) {
			switch screenType {
			case .unloggined:
				self.buttonColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
				self.buttonTextColor = #colorLiteral(red: 0.9566389918, green: 0.9566389918, blue: 0.9566389918, alpha: 1)
			case .loggined:
				self.buttonColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.buttonTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			case.loginScreen:
				self.buttonTextColor = #colorLiteral(red: 0.4470588235, green: 0.4039215686, blue: 0.3411764706, alpha: 1)
				self.buttonColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
			case .other:
				self.buttonTextColor = #colorLiteral(red: 0.8745098039, green: 0.9450980392, blue: 0.7333333333, alpha: 1)
				self.buttonColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
			default:
				self.buttonColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
				self.buttonTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			}
		}
	}
}

extension ColorSet {
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
				self.topViewColor = #colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1)
				self.accentColor = #colorLiteral(red: 0.8745098039, green: 0.9450980392, blue: 0.7333333333, alpha: 1)
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
	static let gradientStart = Color(#colorLiteral(red: 0.1294117647, green: 0.3058823529, blue: 0.06666666667, alpha: 1))
	static let gradientStop = Color(#colorLiteral(red: 0.303658396, green: 0.2938010395, blue: 0.03124490753, alpha: 1))
}
