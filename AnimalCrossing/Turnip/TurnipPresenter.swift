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
    
    var dates = DatesOfCurrentWeek().getWeekDates()
    
    init(networkManager: ITurnipNetworkManager, coreDataManger: ITurnipCoreDataManager) {
        self.coreDataManger = coreDataManger
        self.networkManager = networkManager
    }
    
    
    
    
    
}
