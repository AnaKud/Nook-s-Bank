// PadValidationTestCase.swift
// Created by Anastasiya Kudasheva on 04.03.2022

import XCTest
@testable import AnimalCrossing

final class PadValidationTestCase: XCTestCase {
	func testCheckEqualityForEqualPad() {
		let validationResult = PadValidator.checkEquality("123456", "123456")
		XCTAssertTrue(validationResult)
	}

	func testCheckEqualityForNotEqualPad() {
		let validationResult = PadValidator.checkEquality("123456", "123457")
		XCTAssertFalse(validationResult)
	}

	func testCheckPadNotNumber() {
		let validationResult = PadValidator.check(password: "QWERTY")
		XCTAssertFalse(validationResult)
	}

	func testCheckPadNumber() {
		let validationResult = PadValidator.check(password: "123456")
		XCTAssertTrue(validationResult)
	}

	func testCheckPadNumberWithOneChar() {
		let validationResult = PadValidator.check(password: "12345A")
		XCTAssertFalse(validationResult)
	}

	func testCheckPadCurrentLenght() {
		let validationResult = PadValidator.check(password: "123456")
		XCTAssertTrue(validationResult)
	}

	func testCheckPadWrongLenght5() {
		let validationResult = PadValidator.check(password: "12345")
		XCTAssertFalse(validationResult)
	}

	func testCheckPadWrongLenght7() {
		let validationResult = PadValidator.check(password: "1234567")
		XCTAssertFalse(validationResult)
	}
}
