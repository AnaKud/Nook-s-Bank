//
//  AnimalCrossingTests.swift
//  Created by Anastasiya Kudasheva on 31.10.2021

import XCTest
@testable import AnimalCrossing

class AnimalCrossingTests: XCTestCase {
	func testCSVParser() {
		let sut = CSVParser()
		var array = sut.parseVillagersData()
		array = array.sorted { $0.name < $1.name }
		let item = array[0]
		XCTAssertEqual(array.count, 391)
		XCTAssertEqual(item.name, "Admiral")
		XCTAssertEqual(item.species, "Bird")
		XCTAssertEqual(item.gender, "Male")
		XCTAssertEqual(item.birthday, "27-Jan")
		XCTAssertEqual(item.color, "Black")
	}
}
