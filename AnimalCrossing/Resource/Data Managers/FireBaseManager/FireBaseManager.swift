// FireBaseManager.swift
// Created by Anastasiya Kudasheva on 10.06.2021.

import Firebase
import Foundation

class FireBaseManager {
	static let shared = FireBaseManager()

	let refUser = Database.database().reference(withPath: "users")
	var refBankAccount: DatabaseReference?

	private init() { }
}
