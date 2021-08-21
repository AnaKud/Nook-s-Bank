//
//  UserSettingsViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 16.07.2021.
//

import UIKit

protocol IUserSettingsViewController: AnyObject {
}

class UserSettingsViewController: CustomViewController {
    var interactor: IUserSettingsInteractor

    var contentScrollView = UIScrollView()
    var avatarImageView = UIImageView()
    var nameTextField = UITextView()

    init(interactor: IUserSettingsInteractor) {
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)
        self.screenType = .other
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		self.setupScrollView()
		self.setupImageView()
    }

    func setupScrollView() {
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
        contentScrollView.delegate = self
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
    }

    private func setupImageView() {
        contentScrollView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(contentScrollView).offset(AppContraints.midEdge)
            make.centerX.equalTo(contentScrollView)
            make.height.width.equalTo(AppContraints.UserSettings.sizeImageView)
        }
        avatarImageView.layer.cornerRadius = AppContraints.UserSettings.cornerRadiusImageView
    }
}

extension UserSettingsViewController {
    private func makeChangeButton() -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.width.height.equalTo(AppContraints.PinPadLogin.padSize)
        }
        button.backgroundColor = colors?.passCodeColor.buttonBgColor

        let imageView = UIImageView()
        let image = UIImage(systemName: AppImage.UserSettings.pensil.rawValue)
        imageView.image = image
        imageView.tintColor = colors?.passCodeColor.buttonNumberColor
        button.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.top.equalTo(button).offset(AppContraints.standartEdge)
            make.trailing.bottom.equalTo(button).offset(-AppContraints.standartEdge)
        }
        return button
    }
}

extension UserSettingsViewController: UIScrollViewDelegate {}

extension UserSettingsViewController: IUserSettingsViewController {}
