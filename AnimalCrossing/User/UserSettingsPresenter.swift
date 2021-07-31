//
//  UserSettingsPresenter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 22.07.2021.
//

import Foundation

protocol IUserSettingsPresenter {
    var viewController: IUserSettingsViewController? { get set }
}

class UserSettingsPresenter: IUserSettingsPresenter {
    weak var viewController: IUserSettingsViewController?
    
    
}
