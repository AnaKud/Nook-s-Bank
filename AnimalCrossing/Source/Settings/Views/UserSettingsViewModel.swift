// UserSettingsViewModel.swift
// Created by Anastasiya Kudasheva on 04.12.2021

import Foundation

struct UserSettingsViewModel {
	var settingsType: SettingsType = .userSettings
	var avatar: String? = "Redd"
	var name: String? = "Ann"

	var email: String? = "bla1@bla.ru"
	var oldEmailPassword: String? = "oldEmailPassword"
	var newEmailPassword: String?

	var padCodeExist: Bool {
		!(self.oldPadCode?.isEmpty ?? false)
	}
	var oldPadCode: String? = "133"
	var newPadCode: String? = "458"

	enum SettingsType {
		case register
		case userSettings
	}
	enum PadCodeType {
		case exist
		case empty
		case notUsed
	}
}
