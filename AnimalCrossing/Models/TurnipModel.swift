//
//  TurnipModel.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import Foundation

struct TurnipResponse: Codable {
    let minWeekValue: Int
    let minMaxPattern: [[Int]]
    let avgPattern: [Int]
    let preview: String
}

class TurnipPrices {
    var sundayDate: Date?
    
    var buyPrice: Int
    var turnipCount: Int?
    
    var mondayMorning: Int
    var mondayEvening: Int
    var tuesdayMorning: Int
    var tuesdayEvening: Int
    var wednesdayMorning: Int
    var wednesdayEvening: Int
    var thursdayMorning: Int
    var thursdayEvening: Int
    var fridayMorning: Int
    var fridayEvening: Int
    var saturdayMorning: Int
    var saturdayEvening: Int
    
    var sellPrice: Int?
    
    init(buyPrice: Int, turnipCount: Int?, mondayMorning: Int?, mondayEvening: Int?, tuesdayMorning: Int?, tuesdayEvening: Int?, wednesdayMorning: Int?, wednesdayEvening: Int?, thursdayMorning: Int?, thursdayEvening: Int?, fridayMorning: Int?, fridayEvening: Int?, saturdayMorning: Int?, saturdayEvening: Int?, sellPrice: Int?) {
        self.buyPrice = buyPrice
        self.turnipCount = turnipCount
        self.mondayMorning = mondayMorning ?? 0
        self.mondayEvening = mondayEvening ?? 0
        self.tuesdayMorning = tuesdayMorning ?? 0
        self.tuesdayEvening = tuesdayEvening ?? 0
        self.wednesdayMorning = wednesdayMorning ?? 0
        self.wednesdayEvening = wednesdayEvening ?? 0
        self.thursdayMorning = thursdayMorning ?? 0
        self.thursdayEvening = thursdayEvening ?? 0
        self.fridayMorning = fridayMorning ?? 0
        self.fridayEvening = fridayEvening ?? 0
        self.saturdayMorning = saturdayMorning ?? 0
        self.saturdayEvening = saturdayEvening ?? 0
    
        self.sellPrice = sellPrice
    }
    
    init(fromCoreData model: Turnip) {
        self.sundayDate = model.sundayDate
        self.buyPrice = Int(model.buyPrice)
        self.turnipCount = Int(model.turnipCount)
        self.mondayMorning = Int(model.mondayMorning)
        self.mondayEvening = Int(model.mondayEvening)
        self.tuesdayMorning = Int(model.tuesdayMorning)
        self.tuesdayEvening = Int(model.tuesdayEvening)
        self.wednesdayMorning = Int(model.wednesdayMorning)
        self.wednesdayEvening = Int(model.wednesdayEvening)
        self.thursdayMorning = Int(model.thursdayMorning)
        self.thursdayEvening = Int(model.thursdayEvening)
        self.fridayMorning = Int(model.fridayMorning)
        self.fridayEvening = Int(model.fridayEvening)
        self.saturdayMorning = Int(model.saturdayMorning)
        self.saturdayEvening = Int(model.saturdayEvening)
    }
    
    func pricesArray() -> [Int] {
        return [self.mondayMorning, self.mondayEvening, self.tuesdayMorning, self.tuesdayEvening, self.wednesdayMorning, self.wednesdayEvening, self.thursdayMorning, self.thursdayEvening, self.fridayMorning, self.fridayEvening, self.saturdayMorning, self.saturdayEvening]
    }
    
}
