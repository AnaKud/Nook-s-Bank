// DeviceOwnerAuthentication.swift
// Created by Anastasiya Kudasheva on 15.07.2021.

import LocalAuthentication

protocol IDeviceOwnerAuthentication {
	func authenticationRequest(completion: @escaping (ACVoidResult<BiometricsAuthError>) -> Void)
}

class DeviceOwnerAuthentication: IDeviceOwnerAuthentication {
	static let shared = DeviceOwnerAuthentication()

	private let context = LAContext()

	func authenticationRequest(completion: @escaping (ACVoidResult<BiometricsAuthError>) -> Void) {
		if self.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
			self.context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
										localizedReason: "App login") { success, error in
				switch (success, error) {
				case (true, nil):
					completion(.success)
				case (false, let error as LAError):
					self.handleError(error) { handledError in
						completion(.failure(handledError))
					}
				default :
					completion(.failure(.authError))
				}
			}
		} else {
			completion(.failure(.notConntected))
		}
	}
}

private extension DeviceOwnerAuthentication {
	func handleError(_ error: LAError,
					 completion: @escaping (BiometricsAuthError) -> Void) {
		switch error.code {
		case .authenticationFailed, .userCancel:
			break
		case .userFallback:
			completion(.tooManyAttemp)
		case .passcodeNotSet,
				.touchIDNotAvailable,
				.touchIDNotEnrolled,
				.touchIDLockout:
			completion(.notConntected)
		case .systemCancel,
				.appCancel,
				.invalidContext,
				.notInteractive:
			completion(.authError)
		@unknown default:
			completion(.authError)
		}
	}
}
