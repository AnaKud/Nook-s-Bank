// EmailValidationTestCase.swift
// Created by Anastasiya Kudasheva on 04.03.2022

import XCTest
@testable import AnimalCrossing

final class EmailValidationTestCase: XCTestCase {
	func testEmailValidatorWithCurrentEmail() {
		let validationResult = EmailValidator.check("Ann@mail.ru")
		XCTAssertTrue(validationResult)
	}

	func testEmailValidatorWithWrongCharCountEmail() {
		let validationResult = EmailValidator.check("r@l.ru")
		XCTAssertFalse(validationResult)
	}

	func testEmailValidatorWithoutAtsignEmail() {
		let validationResult = EmailValidator.check("Annmail.ru")
		XCTAssertFalse(validationResult)
	}

	func testEmailValidatorWithoutDotEmail() {
		let validationResult = EmailValidator.check("Ann@mailru")
		XCTAssertFalse(validationResult)
	}

	func testEmailValidatorWrongEmail() {
		let validationResult = EmailValidator.check("Ann.mail@ru")
		XCTAssertFalse(validationResult)
	}
}
