// IFirDictionary.swift
// Created by Anastasiya Kudasheva on 27.01.2022

import Foundation

protocol IFirDictionary {
	func makeDictionary() -> [NSString: Any]
}

protocol IFirKeys {
	var key: NSString { get }
}
