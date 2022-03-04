// UserLocale.swift
// Created by Anastasiya Kudasheva on 14.06.2021.

import Firebase
import Foundation

protocol IUser {
	var uid: String { get }
	var email: String { get }
}

struct UserLocale: IUser {
	let uid: String
	let email: String
}

extension UserLocale {
	init?(user: User) {
		self.uid = user.uid
		guard let userEmail = user.email else { return nil }
		self.email = userEmail
	}
}
