// KeyboardListenerMock.swift
// Created by Anastasiya Kudasheva on 29.12.2021

import CoreGraphics
@testable import KeyboardListener

class KeyboardListenerMock: IKeyboardListener {
	let viewChanger: IViewChanger

	init(viewChanger: IViewChanger) {
		self.viewChanger = viewChanger
	}

	func keyboardWillShow(with height: CGFloat) {
		self.viewChanger.raise(with: height)
	}

	func keyboardWillHide() {
		self.viewChanger.drop()
	}
}
