// EventWebView.swift
// Created by Anastasiya Kudasheva on 28.06.2021.

import UIKit
import WebKit

protocol IEventWebView {
	var urlString: String? { get set }
}

class EventWebView: UIViewController, WKUIDelegate, IEventWebView {
	private var webView: WKWebView?
	var urlString: String?

	override func loadView() {
		let webConfiguration = WKWebViewConfiguration()
		self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
		self.webView?.uiDelegate = self
		self.view = self.webView
		self.tabBarController?.tabBar.isHidden = true
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.openURL()
		self.webView?.accessibilityIdentifier = "eventWebView"
	}
}

private extension EventWebView {
	func openURL() {
		guard let urlString = self.urlString,
			  let url = URL(string: urlString)
		else { return }
		self.webView?.load(URLRequest(url: url))
	}
}
