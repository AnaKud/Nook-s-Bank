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

final class CircleView: UIView {
	private var circleViewSize: CGFloat
	private var firstCharacter: String
	private var colorSet: ColorSet

	private lazy var circleViewCornerRadius = self.circleViewSize / 2

	private let circleView = UIView()
	private let circleLabel = UILabel()

	init(size: CGFloat, firstCharacter: String, screenType: ScreenTypes = .other) {
		self.circleViewSize = size
		self.firstCharacter = firstCharacter
		self.colorSet = ColorSet(for: screenType)
		super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
		self.setupLayouts()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupLayouts() {
		self.circleView.layer.cornerRadius = circleViewCornerRadius
		self.circleView.layer.masksToBounds = true
		self.circleView.backgroundColor = colorSet.circleViewColor.circleColor
		self.circleView.addSubview(circleLabel)
		self.circleLabel.snp.makeConstraints { make in
			make.leading.top.equalTo(circleView).offset(-1)
			make.trailing.bottom.equalTo(circleView)
		}
		self.circleLabel.text = firstCharacter
		self.circleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 18)
		self.circleLabel.textColor = colorSet.circleViewColor.circleTextColor
		self.circleLabel.textAlignment = .center
		self.circleView.layer.masksToBounds = true
		addSubview(self.circleView)
	}
}

class DefaultView: UIView {
	private var screenType: ScreenTypes
	var controllerTitle: String?
	lazy var colors: ColorSet = {
		ColorSet(for: screenType)
	}()
	
	var customView: CustomView {
		CustomView(colorSet: colors)
	}

	let mainView = UIView()
	let topView = UIView()
	let bottomView = UIView()
	let titleLabel = UILabel()
	let contentView = UIView()
	let topImageView = UIImageView()
	let bottomImageView = UIImageView()

	init(controllerTitle: String? = nil, screenType: ScreenTypes = .other) {
		self.controllerTitle = controllerTitle
		self.screenType = screenType
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		self.setupMainView()
		self.setupTopBottomLayout()
		self.setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupMainView() {
		self.addSubview(self.mainView)
		self.mainView.snp.makeConstraints {  make in
			make.top.trailing.leading.bottom.equalToSuperview()
		}
		self.mainView.backgroundColor = self.colors.mainViewColor.backgroundColor
	}

	private func setupTopBottomLayout() {
		self.mainView.addSubview(self.topView)
		self.topView.snp.makeConstraints { make in
			make.top.trailing.leading.equalTo(self.mainView)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
		self.topView.addSubview(self.topImageView)
		self.topImageView.snp.makeConstraints { make in
			make.top.trailing.leading.bottom.equalTo(self.topView)
		}
		self.mainView.addSubview(self.bottomView)
		self.bottomView.snp.makeConstraints { make in
			make.bottom.trailing.leading.equalTo(self.mainView)
			make.height.equalTo(AppContraints.navAndTabHeight)
		}
		self.bottomView.addSubview(self.bottomImageView)
		self.bottomImageView.snp.makeConstraints { make in
			make.top.trailing.leading.bottom.equalTo(self.bottomView)
		}
		self.mainView.addSubview(self.contentView)
		self.contentView.snp.makeConstraints { make in
			make.trailing.leading.equalTo(self.mainView)
			make.top.equalTo(topView.snp.bottom).offset(AppContraints.minEdge)
			make.bottom.equalTo(bottomView.snp.top).offset(-AppContraints.minEdge)
		}
		self.contentView.backgroundColor = .clear
	}

	private func setupView() {
		self.mainView.backgroundColor = self.colors.mainViewColor.backgroundColor
		self.titleLabel.textColor = self.colors.mainViewColor.textColor
		self.titleLabel.numberOfLines = 0

		switch self.screenType {
		case .loggined:
			self.topImageView.image = UIImage(named: AppImage.TopBottomImage.logTop.rawValue)
			self.bottomImageView.image = UIImage(named: AppImage.TopBottomImage.logBottom.rawValue)

		case .unloggined:
			self.topImageView.image = UIImage(named: AppImage.TopBottomImage.unlogTop.rawValue)
			self.bottomImageView.image = UIImage(named: AppImage.TopBottomImage.unlogBottom.rawValue)
		default:
			self.mainView.backgroundColor = self.colors.mainViewColor.backgroundColor
		}
		if self.screenType != .loginScreen {
			self.mainView.addSubview(self.titleLabel)
			self.titleLabel.snp.makeConstraints { make in
				make.top.equalTo(self.mainView).offset(AppContraints.navTitle)
				make.leading.trailing.equalTo(self.mainView)
			}
			self.titleLabel.text = controllerTitle
			self.titleLabel.textAlignment = .center
			self.titleLabel.font = UIFont(name: AppFont.fink.rawValue, size: AppContraints.FontsSize.controllerTitleFont)
		}
	}
}
