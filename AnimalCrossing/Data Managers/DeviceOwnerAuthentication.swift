//
//  DeviceOwnerAuthentication.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 15.07.2021.
//

import Foundation
import LocalAuthentication

protocol IDeviceOwnerAuthentication {
    func authenticationRequest(completion: @escaping (Bool) -> Void)
}

class DeviceOwnerAuthentication: IDeviceOwnerAuthentication {
    static let shared = DeviceOwnerAuthentication()

    private let context = LAContext()

    func authenticationRequest(completion: @escaping (Bool) -> Void) {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please") { success, error in
                if success {
                    completion(true)
                } else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    completion(false)
                }
            }
        }
    }
}
