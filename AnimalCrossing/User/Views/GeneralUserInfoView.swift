//
//  GeneralUserInfoView.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.08.2021.
//

import UIKit

class GeneralUserInfoView: CustomView {
	var nameSectionView = UIView()
	var avatarImageView = UIImageView()
	var nameTextField = UITextField()
	var saveNameButton = UIButton()

	var userEnterDataSectionView = UIView()
	var emailLabel = UILabel()
	var oldPasswordTextField = UITextField()
	var newPasswordTextField = UITextField()
	var newPasswordCheckingTextField = UITextField()
	var saveUserEnterDataButton = UIButton()

	var balanceSectionView = UIView()
	var savingBalanceTextField = UITextField()
	var loanBalanceTextField = UITextField()
}
