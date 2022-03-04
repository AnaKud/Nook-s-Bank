// LoginValidationTestCase.swift
// Created by Anastasiya Kudasheva on 04.03.2022

import XCTest
@testable import AnimalCrossing

final class LoginValidationTestCase: XCTestCase {
	func testCurrentEmail() {
		LoginDataValidator.check(email: "Ann@mail.ru", password: "Ann123!") { validationResult in
			XCTAssertEqual(validationResult, .success(email: "Ann@mail.ru", password: "Ann123!"))
		}
	}

	func testWrongEmail() {
		LoginDataValidator.check(email: "Annmail.ru", password: "Ann123!") { validationResult in
			XCTAssertEqual(validationResult, .error(.emailError))
		}
	}

	func testCurrentPassword() {
		LoginDataValidator.check(email: "Ann@mail.ru", password: "Ann123!") { validationResult in
			XCTAssertEqual(validationResult, .success(email: "Ann@mail.ru", password: "Ann123!"))
		}
	}

	func testWrongPassword() {
		LoginDataValidator.check(email: "Ann@mail.ru", password: "Ann123") { validationResult in
			XCTAssertEqual(validationResult, .error(.passwordError))
		}
	}
}
