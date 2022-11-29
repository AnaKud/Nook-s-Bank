// ExpenseType.swift
// Created by Anastasiya Kudasheva on 16.12.2021

import UIKit

enum ExpenseType {
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
	case work
	case cashback

	var image: UIImage? {
		UIImage(named: name)
	}

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
		case .work: return "work"
		case .cashback: return "cashback"
		}
	}

	// swiftlint:disable:next cyclomatic_complexity
	init(id: Int) {
		switch id {
		case 1: self = .furniture
		case 2: self = .clothing
		case 3: self = .bugs
		case 4: self = .fish
		case 5: self = .seaCreatures
		case 6: self = .tools
		case 7: self = .fossils
		case 8: self = .artwork
		case 9: self = .music
		case 10: self = .garden
		case 11: self = .turnip
		case 12: self = .other
		case 13: self = .work
		case 14: self = .cashback
		default:
			self = .other
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
		case "turnip": self = .turnip
		case "other": self = .other
		default: self = .other
		}
	}

	static func random() -> Self {
		let randomNumber = Int.random(in: 0...11)
		return ExpenseType(id: randomNumber)
	}
}
