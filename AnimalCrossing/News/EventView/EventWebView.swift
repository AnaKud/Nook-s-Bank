//
//  EventWebView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 28.06.2021.
//

import UIKit
import WebKit

class EventWebView: UIViewController, WKUIDelegate {
    var webView: WKWebView?
    var urlString: String?

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        view = webView
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = urlString,
            let url = URL(string: urlString)
        else { return }

        let request = URLRequest(url: url)
        webView?.load(request)
    }
}
