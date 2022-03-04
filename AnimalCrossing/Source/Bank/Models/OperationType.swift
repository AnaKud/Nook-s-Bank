// OperationType.swift
// Created by Anastasiya Kudasheva on 16.12.2021

enum OperationType: String, Decodable {
	case plus
	case minus

	init(_ operationName: String) {
		switch operationName {
		case "plus": self = .plus
		default: self = .minus
		}
	}
}
