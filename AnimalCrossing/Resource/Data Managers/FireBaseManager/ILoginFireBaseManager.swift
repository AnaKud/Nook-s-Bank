// ILoginFireBaseManager.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import ACErrors
import Firebase
import Foundation

protocol ILoginFireBaseManager {
	func login(
		withEmail email: String,
		withPassword password: String,
		completion: @escaping (LoginResult) -> Void
	)
	func logout(completion: @escaping (Result<Void, Error>) -> Void)
	func simpleLogin(withPad pad: String,
					 completion: @escaping (LoginResult) -> Void)
	func simpleLogin(completion: @escaping (LoginResult) -> Void) 
}

extension FireBaseManager: ILoginFireBaseManager {
	// для перезахода
	func simpleLogin(withPad pad: String,
					 completion: @escaping (LoginResult) -> Void) {
		Auth.auth().addStateDidChangeListener { [weak self] _, user in
			self?.checkPadCode(for: user, pad: pad, completion: completion)
		}
	}

	func simpleLogin(completion: @escaping (LoginResult) -> Void) {
		Auth.auth().addStateDidChangeListener { _, user in
			if user != nil {
				completion(.success(.simple))
			} else {
				completion(.error(.biometricAuthError))
			}
		}
	}

	func login(
		withEmail email: String,
		withPassword password: String,
		completion: @escaping (LoginResult) -> Void
	) {
		Auth.auth().signIn(withEmail: email,
						   password: password) { authResult, error in
			switch (authResult, error) {
			case (_, nil): completion(.success(.full))
			default: completion(.error(.notRegister))
			}
		}
	}

	func logout(completion: @escaping (Result<Void, Error>) -> Void) {
		do {
			try Auth.auth().signOut()
		} catch {
			completion(.failure(error))
		}
		completion(.success(()))
	}
}

private extension FireBaseManager {
	func checkPadCode(for user: User?,
					  pad: String,
					  completion: @escaping (LoginResult) -> Void) {
		guard let user = user else { return completion(.error(.notRegister)) }
		let userInfoRef = self.refUser.child(user.uid).child("userInfo")
		userInfoRef.observe(.value) { snapshot in
			guard let padFb = snapshot.childSnapshot(forPath: "pad").value as? String,
			PadValidator.checkEquality(padFb, pad) else {
				return completion(.error(.padError))
			}
			completion(.success(.full))
		}
	}
}