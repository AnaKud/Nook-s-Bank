//
//  CurrentModel.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 28.08.2021.
//

import LocalAuthentication

class Biometric {
	enum BiometricType: String {
		case none
		case touch
		case face
	}

	static var biometricType: BiometricType {
		self.getBiometricType()
	}

	private static func getBiometricType() -> BiometricType {
		let authContext = LAContext()
		if #available(iOS 11, *) {
			_ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
			switch authContext.biometryType {
			case .touchID:
				return .touch
			case .faceID:
				return .face
			default:
				return .none
			}
		} else {
			return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
												 error: nil) ? .touch : .none
		}
	}
}
