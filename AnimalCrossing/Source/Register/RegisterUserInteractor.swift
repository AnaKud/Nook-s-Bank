// RegisterUserInteractor.swift
// Created by Anastasiya Kudasheva on 22.07.2021.

import ACErrors
import Foundation

protocol IRegisterUserInteractor: IRegisterUserButtonCallback {
	func didLoadVC(_ vc: RegisterUserViewController)
	func closeButtonTapped()
}

class RegisterUserInteractor {
	private var presenter: IRegisterUserPresenter
	private var worker: RegisterUserWorker
	private var router: RegisterUserRouter

	init(presenter: IRegisterUserPresenter,
		 worker: RegisterUserWorker,
		 router: RegisterUserRouter) {
		self.presenter = presenter
		self.worker = worker
		self.router = router
	}
}

extension RegisterUserInteractor: IRegisterUserInteractor {
	func didLoadVC(_ vc: RegisterUserViewController) {
		self.router.setupVC(vc)
		self.presenter.setupVC(vc)
	}

	func registerUserButtonTapped(_ user: NewUserViewModel) {
		self.worker.validateNewUser(user) { [weak self] result in
			switch result {
			case .success:
				self?.presenter.showSuccessMessage {
					self?.closeButtonTapped()
				}
			case let .failure(error):
				self?.presenter.showError(with: error)
			}
		}
	}

	func closeButtonTapped() {
		self.router.dismissVC()
	}
}
