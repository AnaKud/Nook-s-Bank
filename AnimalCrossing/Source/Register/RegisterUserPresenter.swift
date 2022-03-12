// RegisterUserPresenter.swift
// Created by Anastasiya Kudasheva on 22.07.2021.

import Foundation
import ACErrors

protocol IRegisterUserPresenter {
	func setupVC(_ viewController: IRegisterUserViewController)
	func showSuccessMessage(completion: (() -> Void)?)
	func showError(with message: ACError)
}

class RegisterUserPresenter {
	private weak var viewController: IRegisterUserViewController?
}

extension RegisterUserPresenter: IRegisterUserPresenter {
	func setupVC(_ viewController: IRegisterUserViewController) {
		self.viewController = viewController
	}

	func showError(with error: ACError) {
		self.viewController?.showAlert(title: error.humanfriendlyTitle,
									   message: error.humanfriendlyMessage,
									   completion: nil)
	}

	func showSuccessMessage(completion: (() -> Void)?) {
		self.viewController?.showAlert(title: nil,
									   message: "You successfully registered. Please login.",
									   completion: completion)
	}
}
