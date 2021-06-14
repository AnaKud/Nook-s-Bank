//
//  CustomAlertController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import UIKit

class CustomAlertController: UIAlertController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
        self.view.layer.cornerRadius = 15
        self.view.layer.borderWidth = 3
        self.view.layer.borderColor =  #colorLiteral(red: 0.5137254902, green: 0.4823529412, blue: 0.4588235294, alpha: 1)
    }
}
