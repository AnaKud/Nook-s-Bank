// OperationType.swift
// Created by Anastasiya Kudasheva on 16.12.2021

enum OperationType: String {
	case plus
	case minus

	init(_ operationName: String?) {
		switch operationName {
		case "minus": self = .minus
		default: self = .plus
		}
	}
}
