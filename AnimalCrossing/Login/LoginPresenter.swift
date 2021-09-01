//
//  LoginPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import Foundation

protocol ILoginPresenter: AnyObject {
	var viewController: ILoginViewController? { get set }
	func presentScreen(forScreenType screenType: ScreenTypes)
}

class LoginPresenter {
	weak var viewController: ILoginViewController?
}

extension LoginPresenter: ILoginPresenter {
	func presentScreen(forScreenType screenType: ScreenTypes) {
		self.viewController?.updateScreenType(screenType: .loginScreen)
		switch screenType {
		case .loginScreen:
			self.viewController?.setupFullLoginView()
		default:
			self.viewController?.setupSimpleLoginView()
		}
	}
}
