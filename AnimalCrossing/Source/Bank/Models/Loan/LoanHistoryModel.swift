// LoanHistoryModel.swift
// Created by Anastasiya Kudasheva on 27.01.2022

import Foundation

struct LoanHistoryViewModel {
	let uid: String
	let date: String
	let value: Int
	let operationType: OperationType
}

extension LoanHistoryViewModel {
	init(object: LoanHistoryTransition) {
		self.uid = object.uid
		self.date = ExpenseDateFormatter.convert(object.date)
		self.value = object.value
		self.operationType = object.operationType
	}
}

class LoanHistoryTransition {
	let uid: String
	let date: Double
	let value: Int
	let operationType: OperationType

	init(value: Int, operationType: OperationType) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.operationType = operationType
	}

	init(_ dto: LoanHistoryDto) {
		self.uid = dto.uid
		self.date = dto.date
		self.value = dto.value
		self.operationType = OperationType(dto.operationType)
	}
}

struct LoanHistoryDto: Decodable {
	let uid: String
	let date: Double
	let value: Int
	let operationType: String

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirKeys.self)
		self.uid = try container.decode(String.self, forKey: .uid)
		self.date = try container.decode(Double.self, forKey: .uid)
		self.value = try container.decode(Int.self, forKey: .uid)
		self.operationType = try container.decode(String.self, forKey: .uid)
	}
}

extension LoanHistoryDto {
	init(value: Int, operationType: String) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.operationType = operationType
	}
}

extension LoanHistoryDto: IFirDictionary {
	enum FirKeys: IFirKeys, CodingKey {
		case uid
		case date
		case value
		case operationType

		var key: NSString {
			switch self {
			case .uid: return "uid"
			case .date: return "date"
			case .value: return "value"
			case .operationType: return "operationType"
			}
		}
	}

	func makeDictionary() -> [NSString: Any?] {
		[
			FirKeys.uid.key: self.uid,
			FirKeys.date.key: "\(self.date)",
			FirKeys.value.key: "\(self.value)",
			FirKeys.operationType.key: self.operationType
		]
	}
}

extension LoanHistoryDto {
	init(object: LoanHistoryTransition) {
		self.uid = object.uid
		self.date = object.date
		self.value = object.value
		self.operationType = object.operationType.rawValue
	}
}
