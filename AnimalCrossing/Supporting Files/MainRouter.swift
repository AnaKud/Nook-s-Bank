//
//  MainRouter.swift
//  Homework-3
//
//  Created by Anastasiya Kudasheva on 05.05.2021.
//

//let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    var exampleViewController: ExampleViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ExampleController") as! ExampleViewController



import UIKit

internal final class MainRouter {
    private let tabbar: UITabBarController
    
  //  private let loginNavigationController: UINavigationController
    //private let loginViewController: LoginViewController
    
//    private let newsNavigationController: UINavigationController
//    private let newsViewController: NewsViewController
//
//    private let bankNavigationController: UINavigationController
//    private let bankViewController: BankViewController
//
//    private let turnipNavigationController: UINavigationController
//    private let turnipViewController: TurnipViewController
    
    internal init() {
        self.tabbar = UITabBarController()
        
//        self.bioViewController = mainStoryboard.instantiateViewController(withIdentifier: "BioViewController") as! BioViewController
//        self.bioNavigationController = UINavigationController(rootViewController: self.bioViewController)
//
//        // to-do
//        self.cvViewController = mainStoryboard.instantiateViewController(withIdentifier: "CVViewController") as! CVViewController
//            //CVViewController()
//        //instantiateViewController(withIdentifier: "CVViewController") as! CVViewController
//        self.cvNavigationController = UINavigationController(rootViewController: self.cvViewController)
//
//        self.inspirationViewController = InspirationViewController()
//        self.inspirationNavigationController = UINavigationController(rootViewController: self.inspirationViewController)
//
//        self.interestsViewController = InterestsViewController()
//        self.interestsNavigationController = UINavigationController(rootViewController: self.interestsViewController)
//
//        self.quotesViewController =  QuotesViewController()
//        self.quotesNavigationController = UINavigationController(rootViewController: quotesViewController)
        
       // self.tabbar.setViewControllers([self.bioNavigationController,
//                                        self.cvNavigationController,
//                                        self.interestsNavigationController],
//                                        animated: true)
//        tabbar.tabBar.items?[1].title = "CV"
//        tabbar.tabBar.items?[1].image = UIImage(systemName: "eyeglasses")
       // tabbar.tabBar.items?[2].title = "Interests"
      //  tabbar.tabBar.items?[2].image = UIImage(systemName: "star.fill")
    }
    
    internal func returnController() -> UITabBarController {
        return self.tabbar
    }
}

