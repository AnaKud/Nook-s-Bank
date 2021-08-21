//
//  CustomViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 06.06.2021.
//

import SnapKit
import UIKit

class CustomViewController: UIViewController {
    var colors: ColorSet?
    var customView: CustomView?
    var screenType: ScreenTypes?
    var controllerTitle: String?

    let topImageView = UIImageView()

    let bottomImageView = UIImageView()
    let titleLabel = UILabel()
    let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.colors = ColorSet(for: screenType)
        self.customView = CustomView(colorSet: colors)
        self.setupTopBottomLayout()
        self.setupView()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func showErrorAlert(withMessage message: FailureCases) {
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
        self.navigationController?.navigationBar.topItem?.title = ""
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

    private func setupView() {
        view.backgroundColor = colors?.mainViewColor.backgroundColor
        titleLabel.textColor = colors?.mainViewColor.textColor
        titleLabel.numberOfLines = 0

        switch screenType {
        case .loggined:
            topImageView.image = UIImage(named: AppImage.TopBottomImage.logTop.rawValue)
            bottomImageView.image = UIImage(named: AppImage.TopBottomImage.logBottom.rawValue)

        case .unloggined:

            topImageView.image = UIImage(named: AppImage.TopBottomImage.unlogTop.rawValue)
            bottomImageView.image = UIImage(named: AppImage.TopBottomImage.unlogBottom.rawValue)
//		case .none:
//			navigationItem.setHidesBackButton(true, animated: true)
//						view.backgroundColor = colors?.mainViewColor.backgroundColor
//		case .loginScreen:
//			let leftImage = UIImage(systemName: AppImage.Login.back.rawValue)
//			let leftButton = UIButton()
//			leftButton.setImage(leftImage, for: .normal)
//			leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//			self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: leftButton), animated: true)
//			
//			let rightImage = UIImage(systemName: AppImage.Login.iconForEmailTF.rawValue)
//			let rightItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(userSettingsButtonTapped))
//			self.navigationItem.setRightBarButton(rightItem, animated: true)
//			
//			navigationItem.setHidesBackButton(true, animated: true)
//			view.backgroundColor = colors?.mainViewColor.backgroundColor
//		case .other:
//			
//           navigationItem.setHidesBackButton(true, animated: true)
		default:
			view.backgroundColor = colors?.mainViewColor.backgroundColor
        }
        if screenType != .loginScreen {
            view.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(view).offset(AppContraints.navTitle)
                make.leading.trailing.equalTo(view)
            }
            titleLabel.text = controllerTitle
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont(name: AppFont.fink.rawValue, size: AppContraints.FontsSize.controllerTitleFont)
        }
    }

    @objc func userSettingsButtonTapped() {
        print("tapped")
       // navDelegate?.userSettingsButtonTapped()
    }
    @objc func backButtonTapped() {
        print("back tapped")
       // navDelegate?.backButtonTapped()
    }
    @objc func logoutButtonTapped() {
        print("back tapped")
// navDelegate?.logoutButtonTapped()
    }
}
