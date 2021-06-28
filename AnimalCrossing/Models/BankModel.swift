//
//  BankModel.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import Foundation
import Firebase

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
    init(value: Int, operationType: OperationType, expenseType: ExpenseType){
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
    init(value: Int, operationType: OperationType){
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
        self.expenseType = ExpenseType.allCases[.random(in: 0...10)]
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
    func converToDictionary() -> Any {
        return["uid": uid, "dateString": dateString, "value": value, "operationType": operationType, "expenseType": expenseType]
    }
    
}

enum ExpenseType: String, CaseIterable {
    case Furniture = "Furniture"
    case Clothing = "Clothing"
    case Bugs = "Bugs"
    case Fish = "Fish"
    case SeaCreatures = "SeaCreatures"
    case Tools = "Tools"
    case Fossils = "Fossils"
    case Artwork = "Artwork"
    case Music = "Music"
    case Garden = "Garden"
    case Other = "Other"
    
    static let allValue: [String] = [ExpenseType.RawValue]()
    
    init?(id : Int) {
        switch id {
        case 0:
            self = .Furniture
        case 1:
            self = .Clothing
        case 2:
            self = .Bugs
        case 3:
            self = .Fish
        case 4:
            self = .SeaCreatures
        case 5:
            self = .Tools
        case 6:
            self = .Fossils
        case 7:
            self = .Artwork
        case 8:
            self = .Music
        case 9:
            self = .Garden
        case 10:
            self = .Other
        default:
            self = .Other
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
        return .Furniture
    case "Clothing":
        return.Clothing
    case "Bugs":
        return .Bugs
    case "Fish":
        return .Fish
    case "SeaCreatures":
        return .SeaCreatures
    case "Tools":
        return .Tools
    case "Fossils":
        return .Fossils
    case"Artwork":
        return .Artwork
    case "Music":
        return .Music
    case "Garden":
        return .Garden
    case "Other":
        return .Other
    default:
        return .Other
    }
}
