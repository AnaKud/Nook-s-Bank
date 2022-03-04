//
// NewUserValidationTestCase.swift
// Created by Anastasiya Kudasheva on 27.12.2021

import XCTest
@testable import AnimalCrossing

final class NewUserValidationTestCase: XCTestCase {
	private var validator: NewUserValidator!

    override func setUp() {
        super.setUp()
		self.validator = NewUserValidator()
    }

    override func tearDown() {
        super.tearDown()
		self.validator = nil
	}

	func testCurrentEmail() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: false,
									pad: nil,
									repetedPad: nil)
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .success(NewUserDto(user)))
		}
	}

	func testWrongEmail() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: false,
									pad: nil,
									repetedPad: nil)
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .error(.emailError))
		}
	}

	func testCurrentPassword() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: false,
									pad: nil,
									repetedPad: nil)
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .success(NewUserDto(user)))
		}
	}

	func testWrongPassword() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123",
									repetedEmailPassword: "Ann123",
									padAvailaible: false,
									pad: nil,
									repetedPad: nil)
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .error(.passwordError))
		}
	}

	func testEqualPassword() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: false,
									pad: nil,
									repetedPad: nil)
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .success(NewUserDto(user)))
		}
	}

	func testNotEqualPassword() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123",
									repetedEmailPassword: "Ann123!",
									padAvailaible: false,
									pad: nil,
									repetedPad: nil)
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .error(.passwordError))
		}
	}

	func testEqualPad() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: true,
									pad: "123456",
									repetedPad: "123456")
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .success(NewUserDto(user)))
		}
	}

	func testNotEqualPad() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: true,
									pad: "123456",
									repetedPad: "123455")
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .error(.padError))
		}
	}

	func testCurrentPad() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: true,
									pad: "123456",
									repetedPad: "123456")
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .success(NewUserDto(user)))
		}
	}

	func testWrongPad() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: true,
									pad: "12345A",
									repetedPad: "12345A")
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .error(.padError))
		}
	}

	func testPadNotCheckedIfPadUnavailaible() {
		let user = NewUserViewModel(name: "Ann",
									avatar: "Ann",
									email: "Ann@mail.ru",
									emailPassword: "Ann123!",
									repetedEmailPassword: "Ann123!",
									padAvailaible: false,
									pad: "12345A",
									repetedPad: "12345A")
		self.validator.validateUser(user) { validationResult in
			XCTAssertEqual(validationResult, .success(NewUserDto(user)))
		}
	}
}
