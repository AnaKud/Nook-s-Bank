//
//  BankModel.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import Firebase
import Foundation

class BankViewModel {
    var currentValue: Int
    var expenses: [ExpenseViewModel]?
    var refBank: DatabaseReference?

    init(currentValue: Int, expenses: [ExpenseViewModel]?) {
        self.currentValue = currentValue
        self.expenses = expenses
        self.refBank = nil
    }
    init?(snapshot: DataSnapshot) {
        guard
            let snapshotValue = snapshot.value as? [String: AnyObject],
            let currentValueFB = snapshotValue["currentValue"] as? Int,
            let expensesFB = snapshotValue["expenses"] as? [ExpenseViewModel]
        else { return nil }
        self.currentValue = currentValueFB
        self.expenses = expensesFB
        self.refBank = snapshot.ref
    }

    func converToDictionary() -> Any {
        return["currentValue": currentValue, "expenses": expenses]
    }
}

class ExpenseViewModel {
    var uid: String
    var dateString: String
    var date: Date?
    var value: Int
    var operationType: OperationType
    var expenseType: ExpenseType
    var imageName: String
    var refExpense: DatabaseReference?
    init(value: Int, operationType: OperationType, expenseType: ExpenseType) {
        self.uid = UUID().uuidString
        let creationDate = Date()
        self.dateString = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm \n dd MMM yyyy"
            return dateFormatter.string(from: creationDate)
        }()
        self.value = value
        self.operationType = operationType
        self.expenseType = expenseType
        self.imageName = expenseType.rawValue
    }
    init(value: Int, operationType: OperationType) {
        self.uid = UUID().uuidString
        let creationDate = Date()
        self.dateString = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm \n dd MMM yyyy"
            return dateFormatter.string(from: creationDate)
        }()
        self.date = creationDate
        self.value = value
        self.operationType = operationType
        self.expenseType = ExpenseType.allCases[.random(in: 0...11)]
        self.imageName = expenseType.rawValue
    }

    init?(snapshot: DataSnapshot) {
        guard
            let snapshotValue = snapshot.value as? [String: AnyObject],
            let uidFB = snapshotValue["uid"] as? String,
            let dateStringFB = snapshotValue["dateString"] as? String,
            let valueFB = snapshotValue["value"] as? Int,
            let operationTypeFB = snapshotValue["operationType"] as? String,
            let expenseTypeFB = snapshotValue["expenseType"] as? String
        else { return nil }
        self.uid = uidFB
        self.dateString = dateStringFB
        self.date = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "y-MM-dd HH:mm"
            return dateFormatter.date(from: dateStringFB)
        }()
        self.value = valueFB
        self.operationType = convertToOperationEnum(stringFromFB: operationTypeFB)
        self.expenseType = convertToExpenseEnum(stringFromFB: expenseTypeFB)
        self.imageName = expenseType.rawValue

        self.refExpense = snapshot.ref
    }

    func converToDictionary() -> Any {
        return["uid": uid, "dateString": dateString, "value": value, "operationType": operationType, "expenseType": expenseType]
    }
}

class ExpenseFB {
    var uid: String
    var dateString: String
    var value: Int
    var operationType: String
    var expenseType: String

    init(fromVM model: ExpenseViewModel) {
        self.uid = model.uid
        self.dateString = model.dateString
        self.value = model.value
        self.operationType = model.operationType.rawValue
        self.expenseType = model.expenseType.rawValue
    }
    init(value: Int, operationType: OperationType, expenseType: ExpenseType) {
        self.uid = UUID().uuidString
        let creationDate = Date()
        self.dateString = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm \n dd MMM yyyy"
            return dateFormatter.string(from: creationDate)
        }()
        self.value = value
        self.operationType = operationType.rawValue
        self.expenseType = expenseType.rawValue
    }

    func converToDictionary() -> Any {
        return["uid": uid, "dateString": dateString, "value": value, "operationType": operationType, "expenseType": expenseType]
    }
}

enum ExpenseType: String, CaseIterable {
    case furniture = "Furniture"
    case clothing = "Clothing"
    case bugs = "Bugs"
    case fish = "Fish"
    case seaCreatures = "SeaCreatures"
    case tools = "Tools"
    case fossils = "Fossils"
    case artwork = "Artwork"
    case music = "Music"
    case garden = "Garden"
    case turnip = "Turnip"
    case other = "Other"

    static let allValue: [String] = [ExpenseType.RawValue]()

	// swiftlint:disable:next cyclomatic_complexity
    init?(id: Int) {
        switch id {
        case 0:
            self = .furniture
        case 1:
            self = .clothing
        case 2:
            self = .bugs
        case 3:
            self = .fish
        case 4:
            self = .seaCreatures
        case 5:
            self = .tools
        case 6:
            self = .fossils
        case 7:
            self = .artwork
        case 8:
            self = .music
        case 9:
            self = .garden
        case 10:
            self = .turnip
        case 11:
            self = .other
        default:
            self = .other
        }
    }
}

enum OperationType: String {
    case plus
    case minus
}

func convertToOperationEnum(stringFromFB: String) -> OperationType {
    switch stringFromFB {
    case "plus":
        return .plus
    case "minus":
        return .minus
    default:
        return .plus
    }
}

func convertToExpenseEnum(stringFromFB: String) -> ExpenseType {
    switch stringFromFB {
    case "Furniture":
        return .furniture
    case "Clothing":
        return.clothing
    case "Bugs":
        return .bugs
    case "Fish":
        return .fish
    case "SeaCreatures":
        return .seaCreatures
    case "Tools":
        return .tools
    case "Fossils":
        return .fossils
    case"Artwork":
        return .artwork
    case "Music":
        return .music
    case "Garden":
        return .garden
    case "Turnip":
        return .turnip
    case "Other":
        return .other
    default:
        return .other
    }
}
