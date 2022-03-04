// VillagerNamesAutoComplete.swift
// Created by Anastasiya Kudasheva on 16.09.2021
// swiftlint:disable all
import Foundation

protocol VillagerNames {
	mutating func getAll() -> [VillagerCSVDto]
	mutating func getResult(for request: String) -> [VillagerCSVDto]
}

struct VillagersAutoComplete: VillagerNames {
	private let csvParser: CSVParser
	private lazy var villagersCsvArray: [VillagerCSVDto] = {
		self.csvParser.parseVillagersData()
	}()
	private var resultArray: [VillagerCSVDto] {
		mutating get {
			self.villagersCsvArray
		}
		set { newValue }
	}

	init() {
		self.csvParser = CSVParser()
		self.villagersCsvArray = csvParser.parseVillagersData()
	}

	mutating func getAll() -> [VillagerCSVDto] {
		self.villagersCsvArray
	}

	mutating func getResult(for request: String) -> [VillagerCSVDto] {
		guard !request.isEmpty, request != " " else { return self.villagersCsvArray }
		let array = self.resultArray.filter {
			$0.name.contains(request)
		}
		self.resultArray = self.villagersCsvArray
		return array
	}
}
