//
//  UserSettingsViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 16.07.2021.
//

import UIKit

protocol IUserSettingsViewController: AnyObject {
}

class UserSettingsViewController: SheetViewController {
	var segmentedControl = UISegmentedControl()
	var segmentedView = UIView()
    var interactor: IUserSettingsInteractor

	let generalInfoView = GeneralUserInfoView(userSettings: UserSettingsViewModel())
	let accountVillageSettingsView = BalanceSettingsView()

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
		let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
		tap.cancelsTouchesInView = false
		self.view.addGestureRecognizer(tap)

		self.colors = ColorSet(for: screenType)
		self.loadUI()
		self.setupSegmentedControl()
		self.segmentedViewSetup()
		self.segmentedControl.selectedSegmentIndex = 0
		self.showGeneralUserInfoView()
    }

	func setupSegmentedControl() {
		self.segmentedControl = CustomSegmentedControl(screenType: self.screenType,
													   items: ["General", "Island", "News"])
		self.contentView.addSubview(self.segmentedControl)
		self.segmentedControl.snp.makeConstraints { make in
			make.top.equalTo(self.contentView).offset(AppContraints.standartEdge)
			make.leading.equalTo(self.contentView).offset(AppContraints.minEdge)
			make.trailing.equalTo(self.contentView).offset(-AppContraints.minEdge)
			make.height.equalTo(AppContraints.doubleEdge)
		}
		self.segmentedControl.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
	}

	func segmentedViewSetup() {
		self.contentView.addSubview(self.segmentedView)
		self.segmentedView.snp.makeConstraints { make in
			make.top.equalTo(self.segmentedControl.snp.bottom)
			make.leading.trailing.bottom.equalTo(self.contentView)
		}
	}

	func showGeneralUserInfoView() {
		self.accountVillageSettingsView.removeFromSuperview()
		self.segmentedView.addSubview(self.generalInfoView)
		self.generalInfoView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	func showAccountVillageSettingsView() {
		self.generalInfoView.removeFromSuperview()
		self.segmentedView.addSubview(accountVillageSettingsView)
		self.accountVillageSettingsView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	@objc
	func selectedValue(sender: UISegmentedControl) {
		if sender == self.segmentedControl {
			let index = self.segmentedControl.selectedSegmentIndex
			switch index {
			case 0:
				self.showGeneralUserInfoView()
				print("generalInfoView")
			case 1:
				self.showAccountVillageSettingsView()
			default:
				print("bls")
			}
		}
	}
}

extension UserSettingsViewController { }

extension UserSettingsViewController: IUserSettingsViewController { }
