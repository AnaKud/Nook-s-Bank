//
//  CustomViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 06.06.2021.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController {
    var colors: ColorsSet?
    var customView: CustomView?
    var userStatus: ScreenTypes?
    var controllerTitle: String?
    
    let topImageView = UIImageView()

    let bottomImageView = UIImageView()
    let titleLabel = UILabel()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colors = ColorsSet(for: userStatus)
        self.customView = CustomView(colorSet: colors)
        self.setupTopBottomLayout()
        self.setupView(forUserStatus: userStatus)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        print(userStatus)
    }

    func showErrrorAlert(withMessage message: FailureCases)  {
        let alert = CustomAlertController(title: "Error", message: message.rawValue, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(saveAction)
        self.present(alert, animated: true)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupTopBottomLayout() {
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = colors?.mainViewColor.navigationItemColor
        self.tabBarController?.tabBar.barTintColor = UIColor.clear
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
        
        view.addSubview(topImageView)
        topImageView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(view)
            make.height.equalTo(AppContraints.navAndTabHeight)
        }
        view.addSubview(bottomImageView)
        bottomImageView.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalTo(view)
            make.height.equalTo(AppContraints.navAndTabHeight)
        }
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(view)
            make.top.equalTo(topImageView.snp.bottom).offset(AppContraints.minEdge)
            make.bottom.equalTo(bottomImageView.snp.top).offset(-AppContraints.minEdge)
        }
        contentView.backgroundColor = .clear
    }
    
    private func setupView(forUserStatus userStatus: ScreenTypes?) {
        view.backgroundColor = colors?.mainViewColor.backgroundColor
        titleLabel.textColor = colors?.mainViewColor.textColor
        
        switch userStatus {
        case .loggined:
            topImageView.image = UIImage(named: "LoginedTop")
            bottomImageView.image = UIImage(named: "LoginedBottom")
        case .unloggined:
            topImageView.image = UIImage(named: "UnLoginedTop")
            bottomImageView.image = UIImage(named: "UnLoginedBottom")
        default:
            view.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
        }
        if userStatus != .loginScreen {
            view.addSubview(titleLabel)
            self.titleLabel.snp.makeConstraints { make in
                make.top.equalTo(view).offset(AppContraints.navTitle)
                make.leading.trailing.equalTo(view)
            }
            titleLabel.text = controllerTitle
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont(name: AppFont.fink.rawValue, size: 40)
        }
    }
}
