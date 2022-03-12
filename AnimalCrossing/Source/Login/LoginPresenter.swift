// LoginPresenter.swift
// Created by Anastasiya Kudasheva on 10.06.2021.

import Foundation

protocol ILoginPresenter: AnyObject, ILoginViewControllerSender {
	func presentScreen(forScreenType screenType: ScreenTypes)
	func showError(with message: ACError, completion: (() -> Void)?)
	func showSuccessEmailReminderAlert()
}

class LoginPresenter {
	private weak var viewController: ILoginViewController?
}

extension LoginPresenter: ILoginPresenter {
	func showSuccessEmailReminderAlert() {
		self.viewController?.showAlert(title: nil, message: "Check your email", completion: nil)
	}

	func showError(with error: ACError, completion: (() -> Void)? = nil) {
		self.viewController?.showAlert(title: error.humanfriendlyTitle,
									   message: error.humanfriendlyMessage,
									   completion: completion)
	}

	func presentScreen(forScreenType screenType: ScreenTypes) {
		switch screenType {
		case .loginScreen:
			self.viewController?.setupFullLoginView()
		default:
			self.viewController?.setupSimpleLoginView()
		}
	}

	func setupVC(_ vc: LoginViewController) {
		self.viewController = vc
	}
}
