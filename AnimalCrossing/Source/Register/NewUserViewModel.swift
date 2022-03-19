// NewUserViewModel.swift
// Created by Anastasiya Kudasheva on 26.12.2021

import Foundation

struct NewUserViewModel {
	let name: String?
	let avatar: String?
	let email: String?
	let emailPassword: String?
	let repetedEmailPassword: String?
	let padAvailaible: Bool
	let pad: String?
	let repetedPad: String?

	init(name: String?,
		 avatar: String?,
		 email: String?,
		 emailPassword: String?,
		 repetedEmailPassword: String?,
		 padAvailaible: Bool,
		 pad: String?,
		 repetedPad: String?) {
		self.name = name
		self.avatar = avatar
		self.email = email
		self.emailPassword = emailPassword
		self.repetedEmailPassword = repetedEmailPassword
		self.padAvailaible = padAvailaible
		self.pad = pad
		self.repetedPad = repetedPad
	}
}

struct NewUserDto {
	let name: String
	let avatar: String
	let email: String
	let emailPassword: String
	let padAvailaible: Bool
	let pad: String?
}

extension NewUserDto {
	init(_ vm: NewUserViewModel) {
		self.name = vm.name ?? ""
		self.avatar = vm.avatar ?? ""
		self.email = vm.email ?? ""
		self.emailPassword = vm.emailPassword ?? ""
		self.padAvailaible = vm.padAvailaible
		self.pad = vm.pad
	}
}

extension NewUserDto: IFirDictionary {
	enum FirKeys: IFirKeys {
		case name
		case avatar
		case email
		case padAvailaible
		case pad

		var key: NSString {
			switch self {
			case .name: return "name"
			case .avatar: return "avatar"
			case .email: return "email"
			case .padAvailaible: return "padAvailaible"
			case .pad: return "pad"
			}
		}
	}

	func makeDictionary() -> [NSString: Any?] {
		[
			FirKeys.name.key: self.name,
			FirKeys.avatar.key: self.avatar,
			FirKeys.email.key: self.email,
			FirKeys.padAvailaible.key: "\(self.padAvailaible)",
			FirKeys.pad.key: self.pad
		]
	}
}

extension NewUserDto: Equatable {
	static func == (lhs: NewUserDto, rhs: NewUserDto) -> Bool {
		let result = (lhs.name == rhs.name
					  && lhs.email == rhs.email)
		return result
	}
}
