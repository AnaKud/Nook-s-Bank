//
//  LoginViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 10.06.2021.
//

import SnapKit
import UIKit

protocol ILoginViewController: AnyObject {
	func updateScreenType(screenType: ScreenTypes)
    func setupFullLoginView()
    func setupSimpleLoginView()
    func showUserNameAlert(withEmail email: String, withPassword password: String)
    func showWarningLabel(withWarningText warningText: String)
    func showErrorAlert(withMessage message: FailureCases)
}

class LoginViewController: CustomViewController {
    var interactor: ILoginInteractor
	
	let fullLoginView = FullLoginView(controllerTitle: AppTitle.nookBank, screenType: .loginScreen)
	let simpleLoginView = SimpleLoginView(controllerTitle: AppTitle.nookBank, screenType: .other)
	
    let welcomeLabel = UILabel()
    let appNameLabel = UILabel()
    var emailTextField = UITextField()
    var passwordNameTextField = UITextField()
    var loginButton = UIButton()
    var registerButton = UIButton()
    var freeEnterButton = UIButton()
    let warningLabel = UILabel()

    init(interactor: ILoginInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		self.interactor.didLoadUI()
    }
	
	func updateScreenType(screenType: ScreenTypes) {
		self.screenType = screenType
		self.colors = ColorSet(for: screenType)
	}

    func setupFullLoginView() {
		self.fullLoginView.callBack = self.interactor
        DispatchQueue.main.async {
			self.view = self.fullLoginView
        }
    }

    func setupSimpleLoginView() {
		self.simpleLoginView.callBack = self.interactor
        DispatchQueue.main.async {
			self.view = self.simpleLoginView
        }
    }
}

extension LoginViewController: ILoginViewController {
    func showWarningLabel(withWarningText warningText: String) {
        warningLabel.text = warningText
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warningLabel.alpha = 1
        }) { [weak self] _ in
            self?.warningLabel.alpha = 0
        }
    }

    func showUserNameAlert(withEmail email: String, withPassword password: String) {
        let alert = CustomAlertController(title: AppTitle.Login.hello, message: AppTitle.Login.nameMessage, preferredStyle: .alert)
        alert.addTextField { nameTextField in
            nameTextField.addAction(UIAction(handler: { _ in
                if alert.textFields?[0].text?.isEmpty == false {
                    alert.actions[0].isEnabled = true
                }
				if nameTextField.text?.isEmpty ?? true {
                    alert.actions[0].isEnabled = false
                }
            }), for: .editingChanged)
        }
        let saveAction = UIAlertAction(title: AppTitle.save, style: .default) { _ in
            guard let nameTextField = alert.textFields?[0], let nameText = nameTextField.text
            else { return }
            self.interactor.registerButtonTapped(withUserName: nameText, email: email, password: password)
        }
        let cancelAction = UIAlertAction(title: AppTitle.cancel, style: .cancel)
        saveAction.isEnabled = false
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}
