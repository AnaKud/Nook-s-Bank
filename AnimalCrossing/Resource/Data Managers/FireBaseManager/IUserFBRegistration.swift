// IUserFBRegistration.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import ACErrors
import Firebase
import Foundation

protocol IUserFBRegistration {
	func register(newUser: NewUserDto, completion: @escaping (ACResult<Void, RegisterError>) -> Void)
}

extension FireBaseManager: IUserFBRegistration {
	func register(newUser: NewUserDto, completion: @escaping (ACResult<Void, RegisterError>) -> Void) {
		Auth.auth()
			.createUser(withEmail: String(newUser.email),
							   password: String(newUser.emailPassword)) { [weak self] user, error in
			guard error == nil,
				  let user = user
			else {
				return completion(.failure(.databaseFail))
			}
			let userRef = self?.refUser.child(user.user.uid)

			let userInfoRef = userRef?.child("userInfo")
			userInfoRef?.setValue(newUser.makeDictionary())
			completion(.success(()))
		}
	}
}
