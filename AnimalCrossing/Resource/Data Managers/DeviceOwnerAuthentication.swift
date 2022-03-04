// DeviceOwnerAuthentication.swift
// Created by Anastasiya Kudasheva on 15.07.2021.

import Foundation
import LocalAuthentication

protocol IDeviceOwnerAuthentication {
	func authenticationRequest(completion: @escaping (Result<Void, BiometricsAuthError>) -> Void)
}

class DeviceOwnerAuthentication: IDeviceOwnerAuthentication {
	static let shared = DeviceOwnerAuthentication()

	private let context = LAContext()

	func authenticationRequest(completion: @escaping (Result<Void, BiometricsAuthError>) -> Void) {
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "App login") { success, error in
				switch (success, error) {
				case (true, nil):
					completion(.success(()))
				default :
					completion(.failure(.authError))
				}
			}
		} else {
			completion(.failure(.notConntected))
		}
	}
}
