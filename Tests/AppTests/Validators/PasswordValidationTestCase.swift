// PasswordValidationTestCase.swift
// Created by Anastasiya Kudasheva on 04.03.2022

import XCTest
@testable import AnimalCrossing

final class PasswordValidationTestCase: XCTestCase {
	func testCheckEqualityForEqualPasswords() {
		let validationResult = PasswordValidator.checkEquality("Ann!23", "Ann!23")
		XCTAssertTrue(validationResult)
	}

	func testCheckEqualityForNotEqualPasswords() {
		let validationResult = PasswordValidator.checkEquality("Ann!23", "Ann23")
		XCTAssertFalse(validationResult)
	}

	func testCheckPasswordCurrentLenght() {
		let validationResult = PasswordValidator.check(password: "Ann!23")
		XCTAssertTrue(validationResult)
	}

	func testCheckPasswordWrongLenght() {
		let validationResult = PasswordValidator.check(password: "Ann!3")
		XCTAssertFalse(validationResult)
	}

	func testCheckPasswordHasSpecialSymbol() {
		let validationResult = PasswordValidator.check(password: "Ann123")
		XCTAssertFalse(validationResult)
	}

	func testCheckPasswordHasUppercasedCharacter() {
		let validationResult = PasswordValidator.check(password: "ann!23")
		XCTAssertFalse(validationResult)
	}

	func testCheckPasswordHasNumber() {
		let validationResult = PasswordValidator.check(password: "Annet!")
		XCTAssertFalse(validationResult)
	}
}
