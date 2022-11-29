// ScreenTypes.swift
// Created by Anastasiya Kudasheva on 19.03.2022

enum Screen {
	case loginScreen(LoginScreenType)
	case mainScreen(ScreenType)

	init(loginType: LoginType) {
		switch loginType {
		case .simple: self = .loginScreen(.simple)
		case .full: self = .loginScreen(.full)
		}
	}
}

extension Screen: Equatable {
	static func == (rhs: Screen, lhs: Screen) -> Bool {
		switch (rhs, lhs) {
		case let (.loginScreen(rhsType), .loginScreen(lhsType)):
			return rhsType == lhsType
		case let (.mainScreen(rhsType), .mainScreen(lhsType)):
			return rhsType == lhsType
		default:
			return false
		}
	}
}

enum ScreenType {
	case unlogined
	case logined(LoginedScreenType)
	case additionalScreen
}

extension ScreenType: Equatable {
	static func == (rhs: ScreenType, lhs: ScreenType) -> Bool {
		switch (rhs, lhs) {
		case (.unlogined, .unlogined),
			(.additionalScreen, .additionalScreen):
			return true
		case let (.logined(rhsType), .logined(lhsType)):
			return rhsType == lhsType
		default:
			return false
		}
	}
}

enum LoginScreenType {
	case full
	case simple
}

extension LoginScreenType: Equatable {
	static func == (rhs: LoginScreenType, lhs: LoginScreenType) -> Bool {
		switch (rhs, lhs) {
		case (.full, .full),
			(.simple, .simple):
			return true
		default:
			return false
		}
	}
}
enum LoginedScreenType {
	case main
	case bells
	case loan
	case poki
	case miles
}

extension LoginedScreenType: Equatable {
	static func == (rhs: LoginedScreenType, lhs: LoginedScreenType) -> Bool {
		switch (rhs, lhs) {
		case (.main, .main),
			(.bells, .bells),
			(.loan, .loan),
			(.poki, .poki),
			(.miles, .miles):
			return true
		default:
			return false
		}
	}
}

enum ColorType {
	case purple
	case gray
	case pink
	case green
	case blue

	init(_ screen: Screen) {
		switch screen {
		case .loginScreen(let loginType):
			switch loginType {
			case .simple:
				self = .green
			case .full:
				self = .purple
			}
		case .mainScreen(let screenType):
			self.init(screenType)
		}
	}

	init(_ screenType: ScreenType) {
		switch screenType {
		case .unlogined: self = .gray
		case .additionalScreen: self = .green
		case .logined(let loginedScreenType): self.init(loginedScreenType)
		}
	}

	init(_ loginedScreenType: LoginedScreenType) {
		switch loginedScreenType {
		case .main: self = .purple
		case .loan: self = .purple
		case .poki: self = .pink
		case .miles: self = .green
		case .bells: self = .blue
		}
	}
}
