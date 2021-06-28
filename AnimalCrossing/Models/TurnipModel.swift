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
    var buyPrice: Int
    
    private var mondayMorning: Int
    private var mondayEvening: Int
    private var tuesdayMorning: Int
    private var tuesdayEvening: Int
    private var wednesdayMorning: Int
    private var wednesdayEvening: Int
    private var thursdayMorning: Int
    private var thursdayEvening: Int
    private var fridayMorning: Int
    private var fridayEvening: Int
    private var saturdayMorning: Int
    private var saturdayEvening: Int
    
    var sellPrice: Int?
    
    init(buyPrice: Int, mondayMorning: Int?, mondayEvening: Int?, tuesdayMorning: Int?, tuesdayEvening: Int?, wednesdayMorning: Int?, wednesdayEvening: Int?, thursdayMorning: Int?, thursdayEvening: Int?, fridayMorning: Int?, fridayEvening: Int?, saturdayMorning: Int?, saturdayEvening: Int?, sellPrice: Int?) {
        self.buyPrice = buyPrice
    
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
    
    func pricesArray() -> [Int] {
        return [self.mondayMorning, self.mondayEvening, self.tuesdayMorning, self.tuesdayEvening, self.wednesdayMorning, self.wednesdayEvening, self.thursdayMorning, self.thursdayEvening, self.fridayMorning, self.fridayEvening, self.saturdayMorning, self.saturdayEvening]
    }
    
}
