//
//  ViewChanger.swift
//  Created by Anastasiya Kudasheva on 29.12.2021

import Foundation
import UIKit

public protocol IViewChanger {
	func raise(with height: CGFloat)
	func drop()
}

public class ViewChanger {
	private let view: UIView

	public init(view: UIView) {
		self.view = view
	}
}

extension ViewChanger: IViewChanger {
	public func raise(with height: CGFloat) {
		self.keyboardWillShow(with: height)
	}

	public func drop() {
		self.keyboardWillHide()
	}
}

private extension ViewChanger {
	func keyboardWillShow(with height: CGFloat) {
		if self.view.frame.origin.y == 0 {
			self.view.frame.origin.y -= height
		}
	}

	func keyboardWillHide() {
		if self.view.frame.origin.y != 0 {
			self.view.frame.origin.y = 0
		}
	}
}
