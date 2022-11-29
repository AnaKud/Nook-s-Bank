// AnimalCrossingUITests.swift
// Created by Anastasiya Kudasheva on 23.04.2022

import XCTest
import Foundation

final class AnimalCrossingUITests: XCTestCase {
	override func setUp() {
		super.setUp()
	}

	func testLoginScreenControls() {
		let app = XCUIApplication()
		app.launchArguments.append("simpleLogin")
		app.launch()
		let checkWelcomeLabel = app.staticTexts["welcomeLabel"].label.contains("Welcome to")
		let checkAppNameLabel = app.staticTexts["appNameLabel"].label.contains("Bank of Nook")
		let checkContinueButton = app.buttons["continueButton"].exists
		XCTAssertTrue(checkWelcomeLabel)
		XCTAssertTrue(checkAppNameLabel)
		XCTAssertTrue(checkContinueButton)
	}

	func testNavigationFromContinueButton() {
		let app = XCUIApplication()
		app.launch()
		app.buttons["continueButton"].tap()
		let checkControllerTitle = app.staticTexts["controllerTitleLabel"].label.contains("News")
		XCTAssertTrue(checkControllerTitle)
	}

	func testTableViewContent() {
		let app = XCUIApplication()
		app.launch()
		app.buttons["continueButton"].tap()
		app.waitForExistence(timeout: 1)
		app.tables["newsTableView"].cells["newsTableViewCell_0"].tap()
		app.waitForExistence(timeout: 1)
		let webViewExist = app.webViews["eventWebView"].exists
		XCTAssertTrue(webViewExist)
	}
}
