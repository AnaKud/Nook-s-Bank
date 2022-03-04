// NewsWorker.swift
// Created by Anastasiya Kudasheva on 22.01.2022

import Foundation

enum NewsSourceType {
	case coreData
	case internet
}

final class NewsWorker {
	private var networkManager: INewsNetworkManager
	private var coreData: INewsCoreDataManager

	private var newsFromInternet = [NewsDTO]()
	private var newsViewModel = [NewsViewModel]()
	private var newsFromCoreData = [NewsViewModel]()

	init(networkManager: INewsNetworkManager, coreData: INewsCoreDataManager) {
		self.networkManager = networkManager
		self.coreData = coreData
	}

	func cellCount() -> Int {
		return self.newsViewModel.count
	}

	func itemForCell(index: Int) -> NewsViewModel {
		return self.newsViewModel[index]
	}

	func makeRequest(_ completion: @escaping (ACResult<NewsSourceType, InternetError>) -> Void) {
		self.networkManager.downloadNews(link: .events) { data in
			if let events = data {
				self.newsFromInternet = events
				self.cleanCoreData()
				self.newsViewModel = self.convertFromInternetToVM(eventsFromInternet: events)
				completion(.success(.internet))
			} else {
				self.newsFromCoreData = self.coreData.loadNews()
				if self.newsFromCoreData.isEmpty {
					completion(.failure(.noInternet))
				} else {
					self.newsViewModel = self.sortEventsFromCoreDataByDay(events: self.newsFromCoreData)
					completion(.success(.coreData))
				}
			}
		}
	}

	private func saveToCoreData(event: NewsViewModel) {
		self.coreData.addNews(news: event)
	}

	private func cleanCoreData() {
		self.coreData.deleteAllNews()
	}
}

private extension NewsWorker {
	func sortEventsFromInternetByDay(events: [NewsDTO]) -> [NewsDTO] {
		let today = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let todayString = dateFormatter.string(from: today)
		print(todayString)
		let subArray = events.drop { event in
			event.date != todayString
		}
		return Array(subArray)
	}

	func sortEventsFromCoreDataByDay(events: [NewsViewModel]) -> [NewsViewModel] {
		let today = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		let todayString = dateFormatter.string(from: today)
		let subArray = events.drop { event in
			event.date != todayString
		}
		return Array(subArray)
	}

	func convertFromInternetToVM(eventsFromInternet: [NewsDTO]) -> [NewsViewModel] {
		var newsVM = [NewsViewModel]()
		let subArray = self.sortEventsFromInternetByDay(events: eventsFromInternet)
		for item in subArray {
			let newItemVM = NewsViewModel(fromInternet: item)
			newsVM.append(newItemVM)
			self.saveToCoreData(event: newItemVM)
		}
		return newsVM
	}
}
