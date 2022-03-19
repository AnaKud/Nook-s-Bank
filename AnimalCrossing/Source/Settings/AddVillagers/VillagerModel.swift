// VillagerModel.swift
// Created by Anastasiya Kudasheva on 23.09.2021

import Foundation
import UIKit
import SwiftUI

// MARK: - VillagerDTO
struct VillagerDTO: Codable {
	let name: String
	let url: String
	let gender: String
	let species: String
	let imageURL: String
	let birthdayMonth: String
	let birthdayDay: String

	enum CodingKeys: String, CodingKey {
		case name, url, gender, species
		case imageURL = "image_url"
		case birthdayMonth = "birthday_month"
		case birthdayDay = "birthday_day"
	}
}

class VillagerCSVDto {
	let name: String
	let species: String
	let gender: String
	let birthday: String
	let color: String

	init(
		name: String,
		species: String,
		gender: String,
		birthday: String,
		color: String
	) {
		self.name = name
		self.species = species
		self.gender = gender
		self.birthday = birthday
		self.color = color
	}
}

class VillagerViewModel {
	let name: String
	let species: String
	let gender: String
	let birthday: String
	let color: VillagerColors

	init(from model: VillagerCSVDto) {
		self.name = model.name
		self.species = model.species
		self.gender = model.gender
		self.birthday = model.birthday
		self.color = VillagerColors(name: model.color.lowercased())
	}
}

class VillagerFullInfoViewModel {
	let name: String
	let species: String
	let gender: String
	let birthday: String

	init(from model: VillagerDTO) {
		self.name = model.name
		self.species = model.species
		self.gender = model.gender
		self.birthday = model.birthdayDay + model.birthdayMonth
	}
}

enum VillagerColors {
	case white
	case yellow
	case lightBlue
	case green
	case brown
	case gray
	case orange
	case red
	case pink
	case blue
	case black
	case beige
	case colorful

	init(name: String) {
		switch name {
		case "white": self = .white
		case "yellow": self = .yellow
		case "lightBlue": self = .lightBlue
		case "green": self = .green
		case "brown": self = .brown
		case "gray": self = .gray
		case "orange": self = .orange
		case "red": self = .red
		case "pink": self = .pink
		case "blue": self = .blue
		case "black": self = .black
		case "beige": self = .beige
		default: self = .colorful
		}
	}

	var color: UIColor {
		switch self {
		case .white: return #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 0.5)
		case .yellow:
			return #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 0.5209540563)
		case .lightBlue:
			return	#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.4963265728)
		case .green:
			return	#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0.5100113825)
		case .brown:
			return	#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 0.5244981374)
		case .gray:
			return	#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.5333454056)
		case .orange:
			return	#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.4712851821)
		case .red:
			return	#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.5177462748)
		case .pink:
			return	#colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 0.5066483858)
		case .blue:
			return	#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.5165821606)
		case .black:
			return	#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 0.508562707)
		case .beige:
			return	#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.5)
		case .colorful:
			return	#colorLiteral(red: 1, green: 0.2581711113, blue: 1, alpha: 0.5)
		}
	}
}
