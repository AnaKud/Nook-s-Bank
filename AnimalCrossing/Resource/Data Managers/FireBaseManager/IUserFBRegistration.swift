// IUserFBRegistration.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import Firebase
import Foundation

protocol IUserFBRegistration {
	func register(newUser: NewUserDto, completion: @escaping (ACVoidResult<RegisterError>) -> Void)
}

extension FireBaseManager: IUserFBRegistration {
	func register(newUser: NewUserDto, completion: @escaping (ACVoidResult<RegisterError>) -> Void) {
		Auth.auth()
			.createUser(withEmail: String(newUser.email),
						password: String(newUser.emailPassword)) { [weak self] user, error in
				guard error == nil, let user = user else {
					return completion(.failure(.databaseFail))
				}
				let userRef = self?.refUser.child(user.user.uid)
				let userInfoRef = userRef?.child("userInfo")
				userInfoRef?.setValue(newUser.makeDictionary())
				userRef?.child("bank").setValue([
					"loan": ["type": "loan"],
					"poki": ["type": "poki"],
					"bells": ["type": "bells"],
					"miles": ["type": "miles"]
				])
				completion(.success)
			}
	}
}
