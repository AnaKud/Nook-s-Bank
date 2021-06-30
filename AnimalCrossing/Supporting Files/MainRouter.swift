//
//  MainRouter.swift
//  Homework-3
//
//  Created by Anastasiya Kudasheva on 05.05.2021.
//

import UIKit

internal final class MainRouter {
    var userStatus: ScreenTypes
    private let tabbar: UITabBarController
    
    private let newsNavigationController: UINavigationController
    private let newsViewController: NewsViewController
    
    private let bankNavigationController: UINavigationController
    private let bankViewController: BankViewController
    
    private let turnipNavigationController: UINavigationController
    private let turnipViewController: TurnipViewController
    
    init(userStatus: ScreenTypes) {
        self.userStatus = userStatus
        let colors = TapBarColor(for: userStatus)
        self.tabbar = UITabBarController()
        
        
        self.newsViewController = NewsAssembly().build(userStatus: userStatus)
        self.newsNavigationController = UINavigationController(rootViewController: self.newsViewController)
        
        self.bankViewController = BankAssembly().build(userStatus: userStatus)
        self.bankNavigationController = UINavigationController(rootViewController: bankViewController)
        
        self.turnipViewController = TurnipAssembly().build(userStatus: userStatus)
        self.turnipNavigationController = UINavigationController(rootViewController: turnipViewController)

        self.tabbar.setViewControllers([self.newsNavigationController, self.bankNavigationController, self.turnipNavigationController], animated: true)
        self.tabbar.tabBar.tintColor = colors.selectedColor
        self.tabbar.tabBar.unselectedItemTintColor = colors.unselectedColor
        
        let newsTabBarItem = UITabBarItem(title: " ", image: UIImage(named: TabbarItems.ImageDefault.news), tag: 0)
        let bankTabBarItem = UITabBarItem(title: " ", image: UIImage(named: TabbarItems.ImageDefault.bank), tag: 1)
        let turnipTabBarItem = UITabBarItem(title: " ", image: UIImage(named: TabbarItems.ImageDefault.turnip), tag: 2)
        
        
        self.newsViewController.tabBarItem = newsTabBarItem
        self.bankViewController.tabBarItem = bankTabBarItem
        self.turnipViewController.tabBarItem = turnipTabBarItem
    }
    
    internal func returnController() -> UITabBarController {
        return self.tabbar
    }
}

