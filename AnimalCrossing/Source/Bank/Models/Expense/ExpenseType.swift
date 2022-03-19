// ExpenseType.swift
// Created by Anastasiya Kudasheva on 16.12.2021

enum ExpenseType {//: String, CaseIterable, Decodable {
	case furniture
	case clothing
	case bugs
	case fish
	case seaCreatures
	case tools
	case fossils
	case artwork
	case music
	case garden
	case turnip
	case other

	var name: String {
		switch self {
		case .furniture: return "furniture"
		case .clothing: return "clothing"
		case .bugs: return "bugs"
		case .fish: return "fish"
		case .seaCreatures: return "seaCreatures"
		case .tools: return "tools"
		case .fossils: return "fossils"
		case .artwork: return "artwork"
		case .music: return "music"
		case .garden: return "garden"
		case .turnip: return "turnip"
		case .other: return "other"
		}
	}

	// swiftlint:disable:next cyclomatic_complexity
	init(id: Int) {
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
	init(_ text: String?) {
		switch text?.lowercased() {
		case "furniture": self = .furniture
		case "clothing": self = .clothing
		case "bugs": self = .bugs
		case "fish": self = .fish
		case "seaCreatures": self = .seaCreatures
		case "tools": self = .tools
		case "fossils": self = .fossils
		case "artwork": self = .artwork
		case "music": self = .music
		case "garden": self = .garden
		case "yurnip": self = .turnip
		case "other": self = .other
		default: self = .other
		}
	}

	static func random() -> Self {
		let randomNumber = Int.random(in: 0...11)
		return ExpenseType(id: randomNumber)
	}
}
