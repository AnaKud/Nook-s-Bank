//
//  CustomView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 29.06.2021.
//

import UIKit

class CustomView {
    var colorSet: ColorSet?
    
    init(for screenType: ScreenTypes?) {
        self.colorSet = ColorSet(for: screenType)
    }
    
    init(colorSet: ColorSet?) {
        self.colorSet = colorSet
    }
    
    func setupTopView(text: String, _ firstCharacter: String) -> UIView {
        let topView = UIView()
        topView.snp.makeConstraints { make in
            make.height.equalTo(AppContraints.CellSizes.topViewHeight)
        }
        topView.backgroundColor = colorSet?.cellColorSet.topViewColor
        
        let circleView = self.makeCircleView(circleViewSize: AppContraints.CellSizes.circleViewSize, firstCharacter: firstCharacter) 
        topView.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.leading.equalTo(topView).offset(AppContraints.CellSizes.cellBgEdge)
            make.centerY.equalTo(topView)
            make.height.width.equalTo(AppContraints.CellSizes.circleViewSize)
        }
        let label = UILabel()
        topView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(circleView.snp.trailing).offset(AppContraints.CellSizes.cellBgEdge)
            make.trailing.equalTo(topView).offset(-AppContraints.CellSizes.cellBgEdge)
            make.top.equalTo(topView).offset(AppContraints.CellSizes.cellBgEdge)
            make.bottom.equalTo(topView).offset(-AppContraints.CellSizes.cellBgEdge)
        }
        label.text = text
        label.font = UIFont(name: AppFont.maruBold.rawValue, size: AppContraints.FontsSize.topViewFont)
        label.textColor = colorSet?.cellColorSet.titleTextColor
        return topView
    }
    
    func makeTextField(height: CGFloat, cornerRadius: CGFloat, editable: Bool) -> UITextField {
        let textfield = UITextField()
        textfield.font = UIFont(name: AppFont.maruLight.rawValue, size: AppContraints.FontsSize.defaultFont)
        textfield.textColor = colorSet?.textfieldColor.textColor
        textfield.layer.cornerRadius = cornerRadius
        textfield.borderStyle = .none
        textfield.isUserInteractionEnabled = editable
        textfield.backgroundColor = colorSet?.textfieldColor.backgroundColor
        textfield.leftViewMode = .always
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.minEdge, height: textfield.frame.height))
        textfield.rightViewMode = .always
        textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.minEdge, height: textfield.frame.height))
        return textfield
    }
    
    func makeTextField(withPlacehoder placeholder: String, height: CGFloat, cornerRadius: CGFloat, withImageName imageName: String, isSecureTextEntry: Bool) -> UITextField {
        let textfield = UITextField()
        textfield.placeholder = placeholder
        textfield.isSecureTextEntry = isSecureTextEntry
        textfield.font = UIFont(name: AppFont.maruLight.rawValue, size: AppContraints.FontsSize.defaultFont)
        textfield.textColor = colorSet?.textfieldColor.textColor
        textfield.layer.cornerRadius = cornerRadius
        textfield.backgroundColor = colorSet?.textfieldColor.backgroundColor
        let view = makeImageLeftViewTF(withImageName: imageName)
        textfield.leftViewMode = .always
        textfield.leftView = view
        textfield.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        textfield.rightViewMode = .always
        textfield.rightView = UIView(frame: CGRect(x: 0, y: 0, width: AppContraints.midEdge, height: textfield.frame.height))
        return textfield
    }
    
    func makeImageLeftViewTF(withImageName imageName: String) -> UIView {
        let viewWithImage = UIView()
        guard let image = UIImage(systemName: imageName) else { return viewWithImage }
        
        let imageView = UIImageView(image: image)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = colorSet?.textfieldColor.imageColor
        viewWithImage.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.equalTo(viewWithImage).offset(AppContraints.Login.imageLeftViewTF)
            make.bottom.trailing.equalTo(viewWithImage).offset(-AppContraints.Login.imageLeftViewTF)
        }
        return viewWithImage
    }
    
    func makeOvalButtonWithCircle(withTitle buttonTitle: String, buttonWidth: CGFloat, buttonHeight: CGFloat) -> UIButton {
        let button = UIButton()
        button.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
            if buttonWidth != 0 {
                make.width.equalTo(buttonWidth)
            }
        }
        let buttonCornerRadius = buttonHeight / 2
        button.layer.cornerRadius = buttonCornerRadius
        button.backgroundColor = colorSet?.ovalButtonColor.buttonColor
        
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
            make.top.bottom.equalTo(button)
            if buttonWidth == 0 {
                make.trailing.equalTo(button).offset(-AppContraints.midEdge)
            }
        }
        titleLabel.text = buttonTitle
        titleLabel.textColor = colorSet?.ovalButtonColor.buttonTextColor
        titleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: AppContraints.FontsSize.loginButtonFont)
        return button
    }
    
    func makeCircleView(circleViewSize: CGFloat, firstCharacter: String) -> UIView {
        let circleView = UIView()
        let circleViewCornerRadius = circleViewSize / 2
        circleView.layer.cornerRadius = circleViewCornerRadius
        circleView.layer.masksToBounds = true
        circleView.backgroundColor = colorSet?.circleViewColor.circleColor
        let circleLabel = UILabel()
        circleView.addSubview(circleLabel)
        circleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(circleView).offset(-1)
            make.trailing.bottom.equalTo(circleView)
        }
        circleLabel.text = firstCharacter
        circleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 18)
        circleLabel.textColor = colorSet?.circleViewColor.circleTextColor
        circleLabel.textAlignment = .center
        circleView.layer.masksToBounds = true
        return circleView
    }
}
