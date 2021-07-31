//
//  UserSettingsWorker.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 22.07.2021.
//

import Foundation

class UserSettingsWorker {
    var fireBaseManager: IUserSettingsFireBaseManager
    
    init(fireBaseManager: IUserSettingsFireBaseManager) {
        self.fireBaseManager = fireBaseManager
    }
    
    
}
