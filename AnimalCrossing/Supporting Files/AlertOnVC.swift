// AlertOnVC.swift
// Created by Anastasiya Kudasheva on 30.12.2021

protocol IAlertOnVC {
	func showAlert(title: String?, message: String, completion: (() -> Void)?)
}
