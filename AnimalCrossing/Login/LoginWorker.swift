//
//  LoginWorker.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 16.07.2021.
//

import Foundation

protocol ValidatorError {

}

enum ValidationResult {
	case success
	case error
}

class Validator {

	let shared = Validator()

	private init() { }

	static func check(email: String?, password: String?, completion: @escaping (String, String) -> Void) {
		checkEmail(email: email) { emailResult, email  in
			switch emailResult {
			case .success:
				checkPassword(password: password) { passwordResult, password in
					switch passwordResult {
					case .success:
						completion(email, password)
					case .error:
						completion("", "")
					}
				}
			case .error:
				completion("", "")
			}
		}
	}

	static func checkEmail(email: String?, completion: @escaping (ValidationResult, String) -> Void) {
		guard let email = email,
			  email.count > 5,
			  email.contains("@"),
			  email.contains(".")
		else {
			completion(.error, "")
			return
		}
		completion(.success, email)
	}
	static func checkPassword(password: String?, completion: @escaping (ValidationResult, String) -> Void) {
		guard let password = password,
			  password.count >= 6
		else {
			completion(.error, "")
			return
		}
		completion(.success, password)
	}
}

class LoginWorker {
    var fireBaseManager: ILoginFireBaseManager
    var keychainService: IKeychainService
    var authenticationService: IDeviceOwnerAuthentication

    init(fireBaseManager: ILoginFireBaseManager,
		 keychainService: IKeychainService,
		 authenticationService: IDeviceOwnerAuthentication) {
        self.fireBaseManager = fireBaseManager
        self.keychainService = keychainService
        self.authenticationService = authenticationService
    }

    func requestBiometricAuth() {
        self.authenticationService.authenticationRequest { result in
            print(result)
        }
    }
	func loginWithFirebase(email: String?, password: String?) {
		Validator.check(email: email, password: password) { [ weak self ] email, password in
			self?.fireBaseManager.login(withEmail: email, withPassword: password)
			self?.keychainService.savePassword(account: email, password: password)
		}
	}

	func registerUser(withUserName name: String?, withEmail email: String?, withPassword password: String?) {
		guard let name = name, name.count > 1 else { return }
		Validator.check(email: email, password: password) { [ weak self ] email, password in
			self?.fireBaseManager.register(withUserName: name, withEmail: email, withPassword: password)
		}
	}

	func forgetButtonTapped() {
		print("forgetButtonTapped")
		UserDefaults.standard.setValue(false, forKey: "simpleLogin")
		// self.router.reloadLoginView(withScreenType: screenType)
	}

	func touchIdButtonTapped() {
		print("touchIdButtonTapped")
		UserDefaults.standard.setValue(true, forKey: "simpleLogin")
		print("userDef \(UserDefaults.standard.value(forKey: "simpleLogin"))")
		DeviceOwnerAuthentication.shared.authenticationRequest { result in
			print(result)
		}
	}

}
