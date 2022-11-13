// ViewChangerTests.swift
// Created by Anastasiya Kudasheva on 29.12.2021

import XCTest
@testable import KeyboardListener

class ViewChangerTests: XCTestCase {
	private var viewChanger: ViewChanger!
	private var view: UIView!

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		self.view = nil
		self.viewChanger = nil
		super.tearDown()
	}

	func testRaiseViewIfYIs0() {
		self.view = self.makeView(yParameter: 0, width: 200, height: 200)
		self.viewChanger = self.makeViewChanger(view: self.view)
		self.viewChanger.raise(with: 10)
		XCTAssertEqual(self.view.frame.origin.y, -10)
	}

	func testRaiseViewIfYIsNot0() {
		self.view = self.makeView(yParameter: 10, width: 200, height: 200)
		self.viewChanger = self.makeViewChanger(view: self.view)
		self.viewChanger.raise(with: 10)
		XCTAssertEqual(self.view.frame.origin.y, 10)
	}

	func testDropView() {
		self.view = self.makeView(yParameter: 10, width: 200, height: 200)
		self.viewChanger = self.makeViewChanger(view: self.view)
		self.viewChanger.drop()
		XCTAssertEqual(self.view.frame.origin.y, 0)
	}
}

private extension ViewChangerTests {
	func makeView(yParameter: Int, width: Int, height: Int) -> UIView {
		UIView(frame: CGRect(x: 0, y: yParameter, width: width, height: height))
	}

	func makeViewChanger(view: UIView) -> ViewChanger {
		ViewChanger(view: view)
	}
}
