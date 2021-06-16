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
        self.tabbar.tabBar.tintColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
        self.tabbar.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.5137254902, green: 0.4823529412, blue: 0.4588235294, alpha: 1)
        
        let newsTabBarItem = UITabBarItem(title: " ", image: UIImage(named: TabbarItems.ImageDefault.news), tag: 0)
        let bankTabBarItem = UITabBarItem(title: " ", image: UIImage(named: TabbarItems.ImageDefault.bank), tag: 1)
        
        self.newsViewController.tabBarItem = newsTabBarItem
        self.bankViewController.tabBarItem = bankTabBarItem
    }
    
    internal func returnController() -> UITabBarController {
        return self.tabbar
    }
}

