//
//  LoginWorker.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 16.07.2021.
//

import Foundation

class LoginWorker {
    var fireBaseManager: ILoginFireBaseManager
    var keychainService: IKeychainService
    var authenticationService: IDeviceOwnerAuthentication
    
    init(fireBaseManager: ILoginFireBaseManager, keychainService: IKeychainService, authenticationService: IDeviceOwnerAuthentication) {
        self.fireBaseManager = fireBaseManager
        self.keychainService = keychainService
        self.authenticationService = authenticationService
    }
    
    func requestBiometricAuth() {
        self.authenticationService.authenticationRequest { result in
            print(result)
        }
    }
    
}
