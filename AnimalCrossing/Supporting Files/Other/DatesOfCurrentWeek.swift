// DatesOfCurrentWeek.swift
// Created by Anastasiya Kudasheva on 28.06.2021.

import Foundation

class DatesOfCurrentWeek {
	func getWeekDates() -> [String]? {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US")
		dateFormatter.dateFormat = "E, dd/MM"
		var startDate = self.getLastSunday()
		var weekDates = [String]()
		for _ in 1...6 {
			if let nextDate = self.getNextDay(afterDate: startDate) {
				let newArrayItem = dateFormatter.string(from: nextDate)
				weekDates.append(newArrayItem)

				startDate = nextDate
			}
		}
		return weekDates
	}
	// change to device time
	func getLastSunday() -> Date? {
		let nowDate = Date()

		let calendar = Calendar.current
		let dayComponent = calendar.dateComponents([.year, .month, .day, .weekday], from: nowDate)

		// Get today is the day of the week
		guard let weekDay = dayComponent.weekday, let day = dayComponent.day  else { return nil }
		// Calculate the difference between the current date and this week's Monday and Sunday
		var diffWithSunday: Int
		if weekDay == 1 {
			print(nowDate)
			return nowDate
			// } else if weekDay == 7 {
			//    diffWithSunday = -6
		} else {
			diffWithSunday = calendar.firstWeekday - weekDay + 1
		}

		// Add the difference in days based on the current date
		var sundayComp = calendar.dateComponents([.year, .month, .day, .hour], from: nowDate)
		sundayComp.hour = -12
		sundayComp.day = day + diffWithSunday
		let sunday = calendar.date(from: sundayComp)
		return sunday
	}

	private func getNextDay(afterDate date: Date?) -> Date? {
		guard let date = date else { return nil }

		let calendar = Calendar.current
		var dayComponent = calendar.dateComponents([.year, .month, .day], from: date)
		guard let day = dayComponent.day else { return nil }
		dayComponent.day = day + 1
		let nextDay = calendar.date(from: dayComponent)
		return nextDay
	}
}
