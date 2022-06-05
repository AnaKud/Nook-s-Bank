// INavigator.swift
// Created by Anastasiya Kudasheva on 13.03.2022

import UIKit

protocol INavigator: AnyObject {
	var currentVC: UIViewController? { get }

	func pushNextVC(_ vc: UIViewController, animated: Bool)
	func popToRootVC(animated: Bool)
	func popToVC(animated: Bool)
	func presentNextVC(_ vc: UIViewController,
					   presentationStyle: UIModalPresentationStyle,
					   animated: Bool)
	func dismissVC(animated: Bool, completion: (() -> Void)?)
}

extension INavigator {
	func pushNextVC(_ vc: UIViewController, animated: Bool = true) {
		self.currentVC?.navigationController?
			.pushViewController(vc, animated: animated)
	}

	func popToRootVC(animated: Bool = true) {
		self.currentVC?.navigationController?.popToRootViewController(animated: animated)
	}

	func popToVC(animated: Bool = true) {
		self.currentVC?.navigationController?.popViewController(animated: animated)
	}

	func presentNextVC(_ vc: UIViewController,
					   presentationStyle: UIModalPresentationStyle = .pageSheet,
					   animated: Bool) {
		vc.modalPresentationStyle = presentationStyle
		self.currentVC?.present(vc, animated: animated)
	}

	func dismissVC(animated: Bool = true, completion: (() -> Void)? = nil) {
		if self.currentVC?.navigationController != nil {
		self.currentVC?.navigationController?.dismiss(animated: animated,
													  completion: completion)
		} else {
			self.currentVC?.dismiss(animated: animated, completion: completion)
		}
	}
}
