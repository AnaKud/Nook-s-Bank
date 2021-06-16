//
//  CustomViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 06.06.2021.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController {
    
    var userStatus: UserStatus?
    var controllerTitle: String?
    
    let topImageView = UIImageView()

    let bottomImageView = UIImageView()
    let titleLabel = UILabel()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTopBottomLayout()
        self.setupView(forUserStatus: userStatus)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    static func makeTextField(withPlacehoder placeholder: String, withImageName imageName: String, isSecureTextEntry: Bool) -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.isSecureTextEntry = isSecureTextEntry
        textfield.font = UIFont(name: AppFont.maruLight.rawValue, size: 20)
        textfield.textColor = #colorLiteral(red: 0.3725490196, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
        textfield.layer.cornerRadius = AppContraints.Login.cornerRadiusTF
        textfield.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
        let view = makeImageLefViewTF(withImageName: imageName)
        textfield.leftViewMode = .always
        textfield.leftView = view
        textfield.snp.makeConstraints { make in
            make.height.equalTo(AppContraints.Login.heightTF)
        }
        textfield.rightViewMode = .always
        textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
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
    
    static func makeOvalButtonWithCircle(withTitle buttonTitle: String, buttonWidth: CGFloat, buttonHeight: CGFloat) -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            make.width.equalTo(buttonWidth)
        }
        let buttonCornerRadius = buttonHeight / 2
        button.layer.cornerRadius = buttonCornerRadius
        button.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
        
        let firstCharacter: String = "\(buttonTitle.first ?? "+")"
        let circleViewSize = buttonHeight * 0.7
        let circleEdges = (buttonHeight - circleViewSize) / 2
        let circleView = makeCircleView(circleViewSize: circleViewSize, firstCharacter: firstCharacter)
        button.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(circleViewSize)
            make.leading.equalTo(button).offset(circleEdges)
            make.centerY.equalTo(button)
        }
        let titleLabel = UILabel()
        button.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleView.snp.trailing).offset(circleEdges)
            make.top.bottom.trailing.equalTo(button)
        }
        titleLabel.text = buttonTitle
        titleLabel.textColor = #colorLiteral(red: 0.5137254902, green: 0.4823529412, blue: 0.4588235294, alpha: 1)
        titleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 16)
        return button
    }
    
    static func makeCircleView(circleViewSize: CGFloat, firstCharacter: String) -> UIView {
        let circleView = UIView()
        let circleViewCornerRadius = circleViewSize / 2
        circleView.layer.cornerRadius = circleViewCornerRadius
        circleView.layer.masksToBounds = true
        circleView.backgroundColor = #colorLiteral(red: 0.5137254902, green: 0.4823529412, blue: 0.4588235294, alpha: 1)
        let circleLabel = UILabel()
        circleView.addSubview(circleLabel)
        circleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(circleView).offset(-2)
            make.trailing.bottom.equalTo(circleView)
        }
        circleLabel.text = firstCharacter
        circleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 18)
        circleLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.8862745098, alpha: 1)
        circleLabel.textAlignment = .center
        circleView.layer.masksToBounds = true
        return circleView
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
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
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
    
    private func setupView(forUserStatus userStatus: UserStatus?) {
        switch userStatus {
        case .loggined:
            topImageView.image = UIImage(named: "LoginedTop")
            bottomImageView.image = UIImage(named: "LoginedBottom")
            view.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
            titleLabel.textColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
        case .unloggined:
            topImageView.image = UIImage(named: "UnLoginedTop")
            bottomImageView.image = UIImage(named: "UnLoginedBottom")
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            titleLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        case .loginScreen:
            view.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.8078431373, blue: 0.9294117647, alpha: 1)
        case .none:
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

