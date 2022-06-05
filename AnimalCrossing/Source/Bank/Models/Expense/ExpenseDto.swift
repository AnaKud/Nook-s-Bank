// ExpenseDTO.swift
// Created by Anastasiya Kudasheva on 16.12.2021

import Foundation
import Firebase

class ExpenseDto: Decodable {
	var uid: String?
	var date: Int
	var value: Int?
	var currencyType: String
	var operationType: String?
	var expenseType: String?

	init(_ anyObject: AnyObject) {
		let dictionary = anyObject as? [String: AnyObject]
		self.uid = dictionary?[FirKeys.uid.stringValue] as? String
		self.date = dictionary?[FirKeys.date.stringValue] as? Int ?? Self.makeDate()
		self.value = dictionary?[FirKeys.value.stringValue] as? Int
		self.currencyType = dictionary?[FirKeys.currencyType.stringValue] as? String ?? "bells"
		self.operationType = dictionary?[FirKeys.operationType.stringValue] as? String
		self.expenseType = dictionary?[FirKeys.expenseType.stringValue] as? String
	}

	init(snapshot: DataSnapshot) {
		let snapshotValue = snapshot.value as? [String: AnyObject]
		self.uid = snapshotValue?[FirKeys.uid.stringValue] as? String
		self.date = snapshotValue?[FirKeys.date.stringValue] as? Int ?? Self.makeDate()
		self.value = snapshotValue?[FirKeys.value.stringValue] as? Int
		self.currencyType = snapshotValue?[FirKeys.currencyType.stringValue] as? String ?? "bells"
		self.operationType = snapshotValue?[FirKeys.operationType.stringValue] as? String
		self.expenseType = snapshotValue?[FirKeys.expenseType.stringValue] as? String
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirKeys.self)
		self.uid = try container.decode(String.self, forKey: .uid)
		self.date = try container.decode(Int.self, forKey: .date)
		self.value = try container.decode(Int.self, forKey: .value)
		self.currencyType = try container.decode(String.self, forKey: .currencyType)
		self.operationType = try container.decode(String.self, forKey: .operationType)
		self.expenseType = try container.decode(String.self, forKey: .operationType)
	}

	private init(uid: String?,
				 date: String?,
				 value: Int?,
				 currencyType: CurrencyType,
				 operationType: OperationType?,
				 expenseType: ExpenseType?) {
		self.uid = uid
		if let date = date {
			self.date = Int(date) ?? Self.makeDate()
		} else {
			self.date = Self.makeDate()
		}
		self.currencyType = currencyType.name
		self.value = value
		self.operationType = operationType?.rawValue
		self.expenseType = expenseType?.name
	}

	convenience init(from object: ExpenseTransition) {
		self.init(uid: object.uid,
				  date: String(describing: object.date),
				  value: object.value,
				  currencyType: object.currencyType,
				  operationType: object.operationType,
				  expenseType: object.expenseType)
	}
}

extension ExpenseDto: Equatable {
	static func == (lhs: ExpenseDto, rhs: ExpenseDto) -> Bool {
		return lhs.uid == rhs.uid
		&& lhs.date == rhs.date
		&& lhs.value == rhs.value
		&& lhs.operationType == rhs.operationType
		&& lhs.expenseType == rhs.expenseType
	}
}

extension ExpenseDto: IFirDictionary {
	enum FirKeys: IFirKeys, CodingKey {
		case uid
		case date
		case value
		case currencyType
		case operationType
		case expenseType

		var key: NSString {
			switch self {
			case .uid: return "uid"
			case .date: return "date"
			case .value: return "value"
			case .currencyType: return "currencyType"
			case .operationType: return "operationType"
			case .expenseType: return "expenseType"
			}
		}
	}

	func makeDictionary() -> [NSString: Any?] {
		[
			FirKeys.uid.key: self.uid,
			FirKeys.date.key: self.date,
			FirKeys.value.key: self.value,
			FirKeys.currencyType.key: self.currencyType,
			FirKeys.operationType.key: self.operationType,
			FirKeys.expenseType.key: self.expenseType
		]
	}
}

extension ExpenseDto {
	convenience init(value: Int, currencyType: CurrencyType, operationType: OperationType) {
		let expenseType = ExpenseType.random()
		self.init(uid: UUID().uuidString,
				  date: String(describing: Date().timeIntervalSince1970),
				  value: value,
				  currencyType: currencyType,
				  operationType: operationType,
				  expenseType: expenseType)
	}
}

private extension ExpenseDto {
	static func makeDate() -> Int {
		return Int(Date().timeIntervalSince1970)
	}
}
