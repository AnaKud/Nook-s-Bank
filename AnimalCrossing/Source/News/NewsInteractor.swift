// NewsInteractor.swift
// Created by Anastasiya Kudasheva on 22.01.2022

import Foundation

protocol INewsInteractor {
	func setupVC(_ controller: NewsViewController?)
	func loadData()
	func cellCount() -> Int
	func cellPressed(index: Int)
	func itemForCell(index: Int) -> NewsViewModel
}

final class NewsInteractor {
	private let worker: NewsWorker
	private let router: INewsRouter
	private let presenter: INewsPresenter

	init(worker: NewsWorker, router: INewsRouter, presenter: INewsPresenter) {
		self.worker = worker
		self.router = router
		self.presenter = presenter
	}
}

extension NewsInteractor: INewsInteractor {
	func loadData() {
		self.worker.makeRequest { result in
			switch result {
			case .success:
				self.presenter.displayTable()
			case .failure(let error):
				self.presenter.showError(with: error)
			}
		}
	}

	func setupVC(_ controller: NewsViewController?) {
		self.router.setupVC(controller)
		self.presenter.setupVC(controller)
	}

	func cellPressed(index: Int) {
		let event = self.worker.itemForCell(index: index)
		let url = event.url
		self.router.routeToWebView(withUrl: url)
	}

	func cellCount() -> Int {
		self.worker.cellCount()
	}

	func itemForCell(index: Int) -> NewsViewModel {
		self.worker.itemForCell(index: index)
	}
}
