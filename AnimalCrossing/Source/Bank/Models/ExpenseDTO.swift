//
//  ExpenseDTO.swift
//  Created by Anastasiya Kudasheva on 16.12.2021

import Foundation
import Firebase

class ExpenseViewModel {
	let uid: String
	let date: String
	let value: Int
	let operationType: OperationType
	let expenseType: String

	init(date: String, value: Int, operationType: OperationType, expenseType: ExpenseType) {
		self.uid = UUID().uuidString
		self.date = date
		self.value = value
		self.operationType = operationType
		self.expenseType = expenseType.rawValue
	}

	init(object: ExpenseTransition) {
		self.uid = object.uid
		self.date = ExpenseDateFormatter.convert(object.date)
		self.value = object.value
		self.operationType = object.operationType
		self.expenseType = object.expenseType.rawValue
	}
}

class ExpenseTransition {
	var uid: String
	var date: Double
	var value: Int
	var operationType: OperationType
	var expenseType: ExpenseType

	init(value: Int, operationType: OperationType, expenseType: ExpenseType) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.operationType = operationType
		self.expenseType = expenseType
	}

	init(value: Int, operationName: String, expenseName: String) {
		self.uid = UUID().uuidString
		self.date = Date().timeIntervalSince1970
		self.value = value
		self.operationType = OperationType(operationName)
		self.expenseType = ExpenseType(expenseName)
	}

	init(_ dto: ExpenseDTO) {
		self.uid = dto.uid
		self.date = dto.date
		self.value = dto.value
		self.operationType = dto.operationType
		self.expenseType = dto.expenseType
	}
}

class ExpenseDTO: Decodable {
	var uid: String
	var date: Double
	var value: Int
	var operationType: OperationType
	var expenseType: ExpenseType

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FirKeys.self)
		self.uid = try container.decode(String.self, forKey: .uid)
		self.date = try container.decode(Double.self, forKey: .date)
		self.value = try container.decode(Int.self, forKey: .value)
		self.operationType = OperationType(try container.decode(String.self, forKey: .operationType))
		self.expenseType = ExpenseType(try container.decode(String.self, forKey: .operationType))
	}

	private init(uid: String,
				date: String,
				value: Int,
				operationType: OperationType,
				expenseType: ExpenseType) {
		self.uid = uid
		self.date = Double(date) ?? Date().timeIntervalSince1970
		self.value = value
		self.operationType = operationType
		self.expenseType = expenseType
	}

	convenience init(from object: ExpenseTransition) {
		self.init(uid: object.uid,
				  date: String(describing: object.date),
				  value: object.value,
				  operationType: object.operationType,
				  expenseType: object.expenseType)
	}
}

extension ExpenseDTO: IFirDictionary {
	enum FirKeys: IFirKeys, CodingKey {
		case uid
		case date
		case value
		case operationType
		case expenseType

		var key: NSString {
			switch self {
			case .uid: return "uid"
			case .date: return "date"
			case .value: return "value"
			case .operationType: return "operationType"
			case .expenseType: return "expenseType"
			}
		}
	}

	func makeDictionary() -> [NSString : Any] {
		[
			FirKeys.uid.key: self.uid,
			FirKeys.date.key: "\(self.date)",
			FirKeys.value.key: "\(self.value)",
			FirKeys.operationType.key: self.operationType,
			FirKeys.expenseType.key: self.expenseType
		]
	}
}

extension ExpenseDTO {
	convenience init(value: Int, operationType: OperationType) {
		let expenseType = ExpenseType.random()
		self.init(uid: UUID().uuidString,
				  date: String(describing: Date().timeIntervalSince1970),
				  value: value,
				  operationType: operationType,
				  expenseType: expenseType)
	}
}

// for Fir
extension ExpenseDTO {
	convenience init?(snapshot: DataSnapshot) {
		guard
			let snapshotValue = snapshot.value as? [String: AnyObject],
			let uidFB = snapshotValue["uid"] as? String,
			let dateFB = snapshotValue["date"] as? String,
			let valueFB = snapshotValue["value"] as? Int,
			let operationTypeFB = snapshotValue["operationType"] as? String,
			let expenseTypeFB = snapshotValue["expenseType"] as? String
		else { return nil }
		self.init(uid: uidFB,
				  date: dateFB,
				  value: valueFB,
				  operationType: OperationType(operationTypeFB),
				  expenseType: ExpenseType(expenseTypeFB))
	}
}

enum ExpenseDateFormatter {
	static func convert(_ date: Double) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm \n dd MMM yyyy"
		return dateFormatter.string(from: Date(timeIntervalSince1970: date))
	}
}
