// NewsRouter.swift
// Created by Anastasiya Kudasheva on 28.06.2021.

import UIKit

protocol INewsRouter {
	func setupVC(_ controller: NewsViewController?)
	func routeToWebView(withUrl url: String?)
	func popToViewController()
}

class NewsRouter: INewsRouter {
	private weak var controller: NewsViewController?

	func setupVC(_ controller: NewsViewController?) {
		self.controller = controller
	}

	func routeToWebView(withUrl url: String?) {
		let nextVC = EventWebView()
		nextVC.urlString = url
		nextVC.modalPresentationStyle = .pageSheet
		self.controller?.present(nextVC, animated: true)
	}

	func popToViewController() {
		self.controller?.navigationController?.popToRootViewController(animated: true)
	}
}
