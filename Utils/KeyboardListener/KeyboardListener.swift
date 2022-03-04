//
//  KeyboardListener.swift
//  Created by Anastasiya Kudasheva on 29.12.2021

import Foundation
import UIKit

public protocol IKeyboardListener {
	var viewChanger: IViewChanger { get }

	func keyboardWillShow(with height: CGFloat)
	func keyboardWillHide()
}

extension IKeyboardListener {
	public func keyboardWillShow(with height: CGFloat) {
		self.viewChanger.raise(with: height)
	}

	public func keyboardWillHide() {
		self.viewChanger.drop()
	}
}
