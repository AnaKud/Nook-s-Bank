// ScreenTypes.swift
// Created by Anastasiya Kudasheva on 19.03.2022

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
