//
//  CustomViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 06.06.2021.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController, UITextFieldDelegate {
    
    let userStatus: UserStatus
    let controllerTitle: String
    
    let titleLabel = UILabel()
    
    init(userStatus: UserStatus, title: String) {
        self.userStatus = userStatus
        self.controllerTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView(forUserStatus: userStatus)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    private func setupView(forUserStatus userStatus: UserStatus) {
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        var image = UIImage()
        switch userStatus {
        case .loggined:
            guard let backgroundImage = UIImage(named: "background_loggined") else { return }
            image = backgroundImage
            
            titleLabel.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
        case .unloggined:
            guard let backgroundImage = UIImage(named: "background_unloggined") else { return }
            image = backgroundImage
            
            titleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        case .loginScreen:
            view.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
        }
        if userStatus != .loginScreen {
        imageView.image = image

        view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(AppContraints.navTitle)
            make.leading.trailing.equalTo(view)
        }
        titleLabel.text = controllerTitle
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: AppFont.fink.rawValue, size: 40)
        }
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    static func makeTextField(withPlacehoder placeholder: String, withImageName imageName: String) -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.font = UIFont(name: AppFont.maruLight.rawValue, size: 20)
        textfield.textColor = #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
        textfield.layer.cornerRadius = AppContraints.Login.cornerRadiusTF
        textfield.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
        let view = makeImageLefViewTF(withImageName: imageName)
        textfield.leftViewMode = .always
        textfield.leftView = view
       // textfield.delegate = self.view.d
        textfield.snp.makeConstraints { make in
            make.height.equalTo(AppContraints.Login.heightTF)
        }

        return textfield
    
    }
    
    static func makeImageLefViewTF(withImageName imageName: String) -> UIView {
        let viewWithImage = UIView()
        guard let image = UIImage(systemName: imageName) else { return viewWithImage }

        let imageView = UIImageView(image: image)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
        viewWithImage.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.equalTo(viewWithImage).offset(AppContraints.Login.imageLeftViewTF)
            make.bottom.trailing.equalTo(viewWithImage).offset(-AppContraints.Login.imageLeftViewTF)
        }
        
        return viewWithImage
    }
    
//    Чтобы инициировать процесс аутентификации, представьте пользователю интерфейс, предлагающий пользователю sendSignInLinkToEmail:actionCodeSettings:completion: свой адрес электронной почты, а затем вызовите sendSignInLinkToEmail:actionCodeSettings:completion: чтобы запросить, чтобы Firebase отправила ссылку для аутентификации на адрес электронной почты пользователя.
    //https://firebase.google.com/docs/auth/ios/email-link-auth?authuser=0

    static func makeOvalButtonWithCircle(withTitle buttonTitle: String, buttonWidth: CGFloat, buttonHeight: CGFloat) -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.width.equalTo(buttonWidth)
        }
        let buttonCornerRadius = buttonHeight / 2
        button.layer.cornerRadius = buttonCornerRadius
        button.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
        let circleView = UIView()
        button.addSubview(circleView)
        let circleViewSize = buttonHeight * 0.7
        let circleEdges = (buttonHeight - circleViewSize) / 2
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(circleViewSize)
            make.leading.equalTo(button).offset(circleEdges)
            make.centerY.equalTo(button)
        }
        let circleViewCornerRadius = circleViewSize / 2
        circleView.layer.cornerRadius = circleViewCornerRadius
        circleView.backgroundColor = #colorLiteral(red: 0.5137254902, green: 0.4823529412, blue: 0.4588235294, alpha: 1)
        let circleLabel = UILabel()
        circleView.addSubview(circleLabel)
        circleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(circleView).offset(-1)
            make.trailing.bottom.equalTo(circleView)
        }
        let firstCharacter: String = "\(buttonTitle.first ?? "+")"
        circleLabel.text = firstCharacter
        circleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 18)
        circleLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
        circleLabel.textAlignment = .center
        
        let titleLabel = UILabel()
        button.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleView.snp.trailing).offset(circleEdges)
            make.top.bottom.trailing.equalTo(button)
        }
        titleLabel.text = buttonTitle
        titleLabel.textColor = #colorLiteral(red: 0.5137254902, green: 0.4823529412, blue: 0.4588235294, alpha: 1)
        titleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 16)
       // titleLabel.font = titleLabel.font.withSize(14)
        
        return button
    }
    
    
    
}

