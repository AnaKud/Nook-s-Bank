// ExpenseType.swift
// Created by Anastasiya Kudasheva on 16.12.2021

enum ExpenseType: String, CaseIterable, Decodable {
	case furniture = "Furniture"
	case clothing = "Clothing"
	case bugs = "Bugs"
	case fish = "Fish"
	case seaCreatures = "SeaCreatures"
	case tools = "Tools"
	case fossils = "Fossils"
	case artwork = "Artwork"
	case music = "Music"
	case garden = "Garden"
	case turnip = "Turnip"
	case other = "Other"

	static let allValue: [String] = [ExpenseType.RawValue]()

	// swiftlint:disable:next cyclomatic_complexity
	init?(id: Int) {
		switch id {
		case 0: self = .furniture
		case 1: self = .clothing
		case 2: self = .bugs
		case 3: self = .fish
		case 4: self = .seaCreatures
		case 5: self = .tools
		case 6: self = .fossils
		case 7: self = .artwork
		case 8: self = .music
		case 9: self = .garden
		case 10: self = .turnip
		case 11: self = .other
		default: self = .other
		}
	}

	// swiftlint:disable:next cyclomatic_complexity
	init(_ text: String) {
		switch text {
		case "Furniture": self = .furniture
		case "Clothing": self = .clothing
		case "Bugs": self = .bugs
		case "Fish": self = .fish
		case "SeaCreatures": self = .seaCreatures
		case "Tools": self = .tools
		case "Fossils": self = .fossils
		case"Artwork": self = .artwork
		case "Music": self = .music
		case "Garden": self = .garden
		case "Turnip": self = .turnip
		case "Other": self = .other
		default: self = .other
		}
	}

	static func random() -> Self {
		Self.allCases[.random(in: 0...11)]
	}
}
