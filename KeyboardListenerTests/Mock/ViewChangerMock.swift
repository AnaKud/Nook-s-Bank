// ViewChangerMock.swift
// Created by Anastasiya Kudasheva on 29.12.2021

import CoreGraphics
@testable import KeyboardListener

class ViewChangerMock: IViewChanger {
	var result = "nil"

	func raise(with height: CGFloat) {
		self.result = "raised"
	}

	func drop() {
		self.result = "droped"
	}
}
