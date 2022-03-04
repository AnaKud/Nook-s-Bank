// KeyboardObserverTests.swift
// Created by Anastasiya Kudasheva on 29.12.2021

import XCTest
import Foundation
@testable import KeyboardListener

class KeyboardObserverTests: XCTestCase {
	private var viewChanger: ViewChangerMock!
	private var keyboardObserver: KeyboardObserver!

	override func setUp() {
		self.viewChanger = ViewChangerMock()
		self.keyboardObserver = self.makeObserver(for: self.viewChanger)
		super.setUp()
	}

	override func tearDown() {
		self.viewChanger = nil
		self.keyboardObserver = nil
		super.tearDown()
	}

	func testStartObservingShowKeyboardWhenInited() {
		let notification = Notification(name: UIResponder.keyboardWillShowNotification,
										object: nil,
										userInfo: [UIResponder.keyboardFrameEndUserInfoKey: CGRect(x: 0, y: 0, width: 0, height: 0)])
		NotificationCenter.default.post(notification)
		XCTAssertEqual(self.viewChanger.result, "raised")
	}

	func testStartObservingHideKeyboardWhenInited() {
		let notification = Notification(name: UIResponder.keyboardWillHideNotification,
										object: nil,
										userInfo: nil)
		NotificationCenter.default.post(notification)
		XCTAssertEqual(self.viewChanger.result, "droped")
	}

	func testStopObservingShowKeyboardWhenStopManualy() {
		self.keyboardObserver.stopObserve()
		let notification = Notification(name: UIResponder.keyboardWillShowNotification,
										object: nil,
										userInfo: [UIResponder.keyboardFrameEndUserInfoKey: CGRect(x: 0, y: 0, width: 0, height: 0)])
		NotificationCenter.default.post(notification)
		XCTAssertEqual(self.viewChanger.result, "droped")
	}
}

private extension KeyboardObserverTests {
	func makeObserver(for changer: ViewChangerMock) -> KeyboardObserver {
		KeyboardObserver(for: KeyboardListenerMock(viewChanger: changer))
	}
}
