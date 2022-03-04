// SupportingFile.swift
// Created by Anastasiya Kudasheva on 10.06.2021.

import Foundation
import UIKit

enum ScreenTypes {
	case loggined
	case unloggined
	case loginScreen
	case other

	init(_ loginType: LoginType) {
		switch loginType {
		case .full: self = .loginScreen
		case .simple: self = .other
		}
	}
}

enum WeekDay: Int {
	case monday
	case tuesday
	case wednesday
	case thursday
	case friday
	case saturday
}

enum TurnipTextFieldText {
	case buyPrice
	case buyCount

	case mondayMorning
	case mondayEvening

	case tuesdayMorning
	case tuesdayEvening

	case wednesdayMorning
	case wednesdayEvening

	case thursdayMorning
	case thursdayEvening

	case fridayMorning
	case fridayEvening

	case saturdayMorning
	case saturdayEvening

	case sellPrice
	case sellCount
}

enum PadKeyBoard: String {
	case zero = "0"
	case one = "1"
	case two = "2"
	case three = "3"
	case four = "4"
	case five = "5"
	case six = "6"
	case seven = "7"
	case eight = "8"
	case nine = "9"
}

enum AdditionalLink: String {
	case events = "nh/events"
	case villagers = "villagers"
}

enum CellReusibleID: String {
	case news = "newsCell"
	case expense = "expenseCell"
	case addVillagers = "addVillagerTableViewCell"
	case newVillager = "newVillagerTableViewCell"
	case avatarRegister = "AvatarCollectionViewCell"
}
