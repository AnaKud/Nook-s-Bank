// errors.swift
// Created by Anastasiya Kudasheva on 30.12.2021

import Foundation
import SwiftUI

@available(*, deprecated, message: "FailureCases shouldn't use")
public enum FailureCases: ACError {
	case fetchError
	case createError
	case saveError
	case updateError
	case deleteError
	case deleteAllError
	case turnipPriceError

	public var humanfriendlyMessage: String {
		switch self {
		case .fetchError: return "Sorry. Can't fetch your data"
		case .createError: return "Sorry. Can't create your data"
		case .saveError: return "Sorry. Can't save your data"
		case .updateError: return "Sorry. Can't update your data"
		case .deleteError: return "Sorry. Can't delete your data"
		case .deleteAllError: return "Sorry. Can't delete all your data"
		case .turnipPriceError: return "You should add Turnip price to calculate it"
		}
	}
}

public protocol ACError {
	var humanfriendlyTitle: String? { get }
	var humanfriendlyMessage: String { get }
}

extension ACError {
	public var humanfriendlyTitle: String? { nil }
}
