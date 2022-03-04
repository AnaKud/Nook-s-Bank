//
//  KeyboardObserver.swift
//  Created by Anastasiya Kudasheva on 29.12.2021

import Foundation
import UIKit

public protocol IKeyboardObserver {
	func startObserve()
	func stopObserve()
}

public class KeyboardObserver: IKeyboardObserver {
	private var listener: IKeyboardListener

	public init(for listener: IKeyboardListener) {
		self.listener = listener
		self.startObserve()
	}

	deinit {
		self.stopObserve()
	}

	public func startObserve() {
		self.addKeyboardWillShowObserver()
		self.addKeyboardWillHideObserver()
	}

	public func stopObserve() {
		NotificationCenter.default.post(name: UIResponder.keyboardWillHideNotification, object: nil)
		self.removeKeyboardWillShowObserver()
		self.removeKeyboardWillHideObserver()
	}
}

private extension KeyboardObserver {
	func addKeyboardWillShowObserver() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(self.notifyShow),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)
	}

	func addKeyboardWillHideObserver() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(self.notifyHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}

	func removeKeyboardWillShowObserver() {
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillShowNotification,
												  object: nil)
	}

	func removeKeyboardWillHideObserver() {
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillHideNotification,
												  object: nil)
	}
}

@objc
private extension KeyboardObserver {
	func notifyShow(_ notification: NSNotification) {
		if let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
			self.listener.keyboardWillShow(with: height)
		}
	}

	func notifyHide(_ notification: NSNotification) {
		self.listener.keyboardWillHide()
	}
}
