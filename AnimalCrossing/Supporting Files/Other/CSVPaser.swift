//
//  CSVParser.swift
//  Created by Anastasiya Kudasheva on 06.12.2021

import Foundation

class CSVParser {
	func parseVillagersData() -> [VillagerCSVDto] {
		var array = [VillagerCSVDto]()

		guard let filepath = Bundle.main.path(forResource: "villagers", ofType: "csv") else { return [VillagerCSVDto]() }
		var data = ""
		do {
			data = try String(contentsOfFile: filepath)
		} catch {
			print(error.localizedDescription)
			return array
		}

		var rows = data.components(separatedBy: "\n")
		rows.removeFirst()
		rows.removeLast()

		for row in rows {
			let columns = row.components(separatedBy: ",")
			let newVillager = VillagerCSVDto(name: columns[0],
											  species: columns[1],
											  gender: columns[2],
											  birthday: columns[5],
											  color: columns[10])
			array.append(newVillager)
		}
		return array
	}
}
