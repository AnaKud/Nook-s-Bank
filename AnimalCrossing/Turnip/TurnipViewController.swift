//
//  TurnipViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 27.06.2021.
//

import UIKit

class TurnipViewController: CustomViewController {

    var presenter: ITurnipPresenter
    
    init(presenter: ITurnipPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        let array = self.presenter.dates
        print(array)
    }
    



}
