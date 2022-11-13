// LoginValidationTestCase.swift
// Created by Anastasiya Kudasheva on 04.03.2022

import XCTest
@testable import AnimalCrossingBank

final class LoginValidationTestCase: XCTestCase {
	func testCurrentEmail() {
		LoginDataValidator.check(email: "Ann@mail.ru", password: "Ann123!") { validationResult in
			let referenceValue = ValidatedUserData(email: "Ann@mail.ru", password: "Ann123!")
			XCTAssertEqual(validationResult, .success(referenceValue))
		}
	}

	func testWrongEmail() {
		LoginDataValidator.check(email: "Annmail.ru", password: "Ann123!") { validationResult in
			XCTAssertEqual(validationResult, .failure(.emailFormatError))
		}
	}

	func testCurrentPassword() {
		LoginDataValidator.check(email: "Ann@mail.ru", password: "Ann123!") { validationResult in
			let referenceValue = ValidatedUserData(email: "Ann@mail.ru", password: "Ann123!")
			XCTAssertEqual(validationResult, .success(referenceValue))
		}
	}

	func testWrongPassword() {
		LoginDataValidator.check(email: "Ann@mail.ru", password: "Ann123") { validationResult in
			XCTAssertEqual(validationResult, .failure(.passwordFormatError))
		}
	}
}
