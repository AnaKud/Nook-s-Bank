//
//  NewsRouter.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 28.06.2021.
//

import UIKit

protocol INewsRouter {
    var controller: NewsViewController? { get set }
    func routeToWebView(withUrl url: String?)
    func popToViewController()
}

class NewsRouter: INewsRouter {
    weak var controller: NewsViewController?
    func routeToWebView(withUrl url: String?) {
        let nextVC = EventWebView()
        nextVC.urlString = url
        nextVC.modalPresentationStyle = .pageSheet
        self.controller?.present(nextVC, animated: true)
    }

    func popToViewController() {
		self.controller?.navigationController?.popToRootViewController(animated: true)
    }
}
