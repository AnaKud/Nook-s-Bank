// NewsModel.swift
// Created by Anastasiya Kudasheva on 11.06.2021.

import Foundation

class NewsDTO: Codable {
	var date: String
	var event: String
	var url: String

	init(date: String, event: String, url: String) {
		self.date = date
		self.event = event
		self.url = url
	}
}

class NewsViewModel {
	var date: String
	var event: String
	var url: String
	var type: NewsType

	init(date: String, event: String, url: String) {
		self.date = date
		self.event = event
		self.url = url
		self.type = NewsType(event)
	}

	init(fromInternet model: NewsDTO) {
		self.date = Self.convertDate(model.date)
		self.event = model.event
		self.url = model.url
		self.type = NewsType(model.event)
	}

	init?(fromCoreData model: News) {
		guard let modelDate = model.date,
			  let modelEvent = model.event,
			  let modelUrl = model.url,
			  let modelType = model.type
		else { return nil }
		self.date = modelDate
		self.event = modelEvent
		self.url = modelUrl
		self.type = NewsType(modelType)
	}

	private static func convertDate(_ date: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let internetDate = dateFormatter.date(from: date)
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "dd MMM yyyy"
		return dateFormatter.string(from: internetDate ?? Date())
	}
}

class NewsFireBase {
	var date: String
	var event: String
	var url: String

	init(date: String, event: String, url: String) {
		self.date = date
		self.event = event
		self.url = url
	}
}

enum NewsType {
	case shopping
	case birthday
	case event

	init(_ event: String) {
		if event.lowercased().contains("shopping") {
			self = .shopping
		} else if event.lowercased().contains("birthday") {
			self = .birthday
		} else {
			self = .event
		}
	}

	var name: String {
		switch self {
		case .shopping: return "shopping"
		case .birthday: return "birthday"
		case .event: return "event"
		}
	}

	var abbreviation: String {
		switch self {
		case .shopping: return "S"
		case .birthday: return "B"
		case .event: return "E"
		}
	}
}
