//
//  TurnipPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import Foundation

protocol ITurnipPresenter {
    var dates: [String]? { get }
}

class TurnipPresenter: ITurnipPresenter {
    var coreDataManger: ITurnipCoreDataManager
    var networkManager: ITurnipNetworkManager
    
    var turnipPrices: TurnipPrices?
    var turnipCoreData: TurnipPrices?
    var lastSunday = DatesOfCurrentWeek().getLastSunday()
    var dates = DatesOfCurrentWeek().getWeekDates()
    
    init(networkManager: ITurnipNetworkManager, coreDataManger: ITurnipCoreDataManager) {
        self.coreDataManger = coreDataManger
        self.networkManager = networkManager
        self.checkToCleanCoreData()
    }
    
    
    
    
    
    private func fetchTurnipFromCoreData() {
        self.turnipCoreData = self.coreDataManger.loadTurnip()
    }
    
    private func checkToCleanCoreData() {
        self.fetchTurnipFromCoreData()
        if turnipCoreData?.sundayDate != lastSunday {
            self.coreDataManger.deleteTurnip()
        }
    }
}
