// NewsPresenter.swift
// Created by Anastasiya Kudasheva on 11.06.2021.

import Foundation

protocol INewsPresenter: AnyObject {
	func setupVC(_ controller: NewsViewController?)
	func showError(with message: ACError)
	func displayTable()
}

final class NewsPresenter: INewsPresenter {
	private var view: NewsViewController?

	func setupVC(_ controller: NewsViewController?) {
		self.view = controller
	}

	func showError(with message: ACError) {
		self.view?.showAlert(with: message.humanfriendlyMessage, completion: nil)
	}

	func displayTable() {
		DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.5)) {
			self.view?.displayTable()
		}
	}

	private func refreshView() {
		self.view?.refreshView()
	}
}
