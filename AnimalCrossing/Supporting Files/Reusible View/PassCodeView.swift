//
//  PassCodeView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 14.07.2021.
//

import UIKit

class PassCodeView: UIView, UITextInputTraits {
    var code: String = "" {
        didSet {
            updateStack(by: code)
        }
    }
    
    let maxLength = AppContraints.PinPadLogin.maxPasswordLength
    let colorSet = ColorSet.PassCodeViewColor(for: .other)
    let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPins()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var canBecomeFirstResponder: Bool {
        return false
    }
    
    private func setupPins() {
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.width.equalTo(AppContraints.PinPadLogin.passCodeWidth)
        }
        self.backgroundColor = colorSet.backgroundColor
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        updateStack(by: code)
    }
    
    private func updateStack(by code: String) {
        var emptyPins: [UIView] = Array(0..<maxLength).map { _ in emptyPin() }
        let userPinLength = code.count
        let pins: [UIView] = Array(0..<userPinLength).map { _ in pin() }
        
        for (index, element) in pins.enumerated() {
            emptyPins[index] = element
        }
        stack.removeAllArrangedSubViews()
        for view in emptyPins {
            stack.addArrangedSubview(view)
        }
    }
    
    private func emptyPin() -> UIView {
        let pin = Pin()
        return pin
    }
    
    private func pin() -> UIView {
        let pin = Pin()
        pin.pin.backgroundColor = colorSet.pinColor
        return pin
    }
}

extension PassCodeView: UIKeyInput {
    var hasText: Bool {
        return code.count > 0
    }
    
    func insertText(_ text: String) {
        if code.count == maxLength {
            return
        }
        code.append(contentsOf: text)
        print(text)
    }
    
    func deleteBackward() {
        if hasText {
            code.removeLast()
            print("text deleted")
        }
    }
}

class Pin: UIView {
    let pin = UIView()
    let colorSet = ColorSet.PassCodeViewColor(for: .other)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupPin()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPin() {
        addSubview(pin)
        pin.snp.makeConstraints { make in
            make.height.width.equalTo(AppContraints.PinPadLogin.pinSize)
        }
        pin.layer.cornerRadius = AppContraints.PinPadLogin.pinCorner
        pin.layer.borderWidth = AppContraints.PinPadLogin.pinBorder
        pin.layer.borderColor = colorSet.pinBorderColor
        pin.layer.masksToBounds = true
    }
}

extension UIStackView {
    func removeAllArrangedSubViews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
