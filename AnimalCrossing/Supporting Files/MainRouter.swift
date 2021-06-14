//
//  MainRouter.swift
//  Homework-3
//
//  Created by Anastasiya Kudasheva on 05.05.2021.
//

import UIKit

internal final class MainRouter {
    var userStatus: UserStatus
    var title: String
    private let tabbar: UITabBarController
    
    private let newsNavigationController: UINavigationController
    private let newsViewController: NewsViewController
    
    private let bankNavigationController: UINavigationController
    private let bankViewController: BankViewController
    
    init(userStatus: UserStatus, title: String) {
        self.userStatus = userStatus
        self.title = title
        self.tabbar = UITabBarController()
        
        self.newsViewController = NewsAssembly().build(userStatus: userStatus, title: title)
        self.newsNavigationController = UINavigationController(rootViewController: self.newsViewController)
        
        self.bankViewController = BankAssembly().build(userStatus: userStatus, title: title)
        self.bankNavigationController = UINavigationController(rootViewController: bankViewController)

        self.tabbar.setViewControllers([self.newsNavigationController, self.bankNavigationController], animated: true)
        
        let newsTabBarItem = UITabBarItem(title: "", image: UIImage(named: TabbarItems.ImageDefault.news), selectedImage: UIImage(named: TabbarItems.ImagePressed.news))
        let bankTabBarItem = UITabBarItem(title: "", image: UIImage(named: TabbarItems.ImageDefault.bank), selectedImage: UIImage(named: TabbarItems.ImagePressed.bank))
        
        self.newsViewController.tabBarItem = newsTabBarItem
        self.bankViewController.tabBarItem = bankTabBarItem
        
        self.tabbar.modalPresentationStyle = .fullScreen
    }
    
    internal func returnController() -> UITabBarController {
        return self.tabbar
    }
}

