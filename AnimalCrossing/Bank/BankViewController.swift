//
//  BankViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 13.06.2021.
//

import UIKit

protocol IBankViewController {
    func interfaceWithData()
    func refreshView(currentValue: String)
    func showAddExpenseAlert(expense: @escaping (ExpenseViewModel) -> ())
    func showErrrorAlert(withMessage: FailureCases)
    var currentAccount: BankViewModel? { get set }
}

class BankViewController: CustomViewController {
    var currentAccount: BankViewModel?
    let bankAccountView = UIView()
    let coinImageView = UIImageView()
    let currentAccountTitleLabel = UILabel()
    let currentAccountLabel = UILabel()
    let historyTitleLabel = UILabel()
    let historyView = UIView()
    var expensesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let plusButton = UIButton()
    var plusImage: UIImage?
    var activityIndicatorView = UIActivityIndicatorView()
    
    var presenter: IBankPresenter
    
    init(presenter: IBankPresenter) {
        self.presenter = presenter
        self.currentAccount = presenter.account
        super.init(nibName: nil, bundle: nil)
        self.presenter.getCurrentUser()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter.loadView(view: self)
        self.displayActivity()
        self.initailInterface()
        self.dataForUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.getCurrentUser()
    }
    
    private func displayActivity() {
        self.contentView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }
        self.activityIndicatorView.style = .large
        self.activityIndicatorView.color = colors?.activityIndicatorColor.activityColor
       
        self.activityIndicatorView.startAnimating()
        self.activityIndicatorView.hidesWhenStopped = true
    }
    
    private func dataForUser(){
        switch screenType {
        case .loggined:
            currentAccountTitleLabel.text = AppTitle.Bank.currentAccountTitle
            coinImageView.image = UIImage(named: AppImage.Bank.coinLogin.rawValue)
            historyTitleLabel.text = AppTitle.Bank.purchaseHistory
            plusImage = UIImage(named: AppImage.Bank.plusLogin.rawValue)
        default:
            currentAccountTitleLabel.text = AppTitle.Bank.demoTitle
            coinImageView.image = UIImage(named: AppImage.Bank.coinUnLogin.rawValue)
            historyTitleLabel.text = AppTitle.Bank.demoHistory
            plusImage = UIImage(named: AppImage.Bank.plusUnlogin.rawValue)
        }
    }
    
    private func setupBankAccountView() {
        self.contentView.addSubview(bankAccountView)
        bankAccountView.snp.makeConstraints { make in
            make.leading.top.equalTo(self.contentView).offset(AppContraints.midEdge)
            make.trailing.equalTo(self.contentView).offset(-AppContraints.midEdge)
            make.height.equalTo(AppContraints.Bank.bankAccountViewHeight)
        }
        bankAccountView.layer.cornerRadius = AppContraints.standartCornerRadius
        bankAccountView.backgroundColor = colors?.bankViewColor.backgroundViewColor
        
        bankAccountView.addSubview(coinImageView)
        coinImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(bankAccountView).offset(AppContraints.minEdge)
            make.bottom.equalTo(bankAccountView).offset(-AppContraints.minEdge)
            make.width.equalTo(coinImageView.snp.height)
        }
        
        bankAccountView.addSubview(currentAccountTitleLabel)
        currentAccountTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(AppContraints.midEdge)
            make.top.equalTo(bankAccountView).offset(AppContraints.minEdge)
            make.trailing.equalTo(bankAccountView).offset(-AppContraints.minEdge)
        }
        currentAccountTitleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: AppContraints.FontsSize.bankAccontFont)
        currentAccountTitleLabel.textColor = colors?.bankViewColor.titleTextColor
        
        bankAccountView.addSubview(currentAccountLabel)
        currentAccountLabel.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(AppContraints.midEdge)
            make.top.equalTo(currentAccountTitleLabel.snp.bottom).offset(AppContraints.minEdge)
            make.trailing.bottom.equalTo(bankAccountView).offset(-AppContraints.minEdge)
        }
        currentAccountLabel.font = UIFont(name: AppFont.maruLight.rawValue, size: AppContraints.FontsSize.bankAccontFont)
        currentAccountLabel.textColor = colors?.bankViewColor.itemTextColor
        currentAccountLabel.text = self.presenter.returnCurrentAccountValue()
    }
    
    private func setupPlusButton() {
        self.contentView.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-AppContraints.minEdge)
            make.height.width.equalTo(AppContraints.Bank.plusButtonHeight)
        }
        
        plusButton.setImage(plusImage, for: .normal)
		plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    private func setupViewForCollection() {
        self.contentView.addSubview(historyView)
        historyView.snp.makeConstraints { make in
            make.top.equalTo(bankAccountView.snp.bottom).offset(AppContraints.midEdge)
            make.leading.equalTo(self.contentView).offset(AppContraints.midEdge)
            make.trailing.equalTo(self.contentView).offset(-AppContraints.midEdge)
            make.bottom.equalTo(plusButton.snp.top).offset(-AppContraints.midEdge)
        }
        historyView.layer.cornerRadius = AppContraints.standartCornerRadius
        historyView.backgroundColor = colors?.bankViewColor.backgroundViewColor
        historyView.layer.masksToBounds = true
        
        historyView.addSubview(historyTitleLabel)
        historyTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(historyView).offset(AppContraints.midEdge)
            make.top.equalTo(historyView).offset(AppContraints.minEdge)
            make.trailing.equalTo(historyView).offset(-AppContraints.midEdge)
        }
        historyTitleLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: AppContraints.FontsSize.bankAccontFont)
        historyTitleLabel.textColor = colors?.bankViewColor.titleTextColor
        
        historyView.addSubview(expensesCollectionView)
        expensesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(historyTitleLabel.snp.bottom).offset(AppContraints.minEdge)
            make.leading.trailing.bottom.equalTo(historyView)
        }
        expensesCollectionView.backgroundColor = .clear
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = AppContraints.midEdge
        expensesCollectionView.collectionViewLayout = layout
        self.expensesCollectionView.delegate = self
        self.expensesCollectionView.dataSource = self
        expensesCollectionView.register(ExpenseCollectionViewCell.self, forCellWithReuseIdentifier: CellReusibleID.expense.rawValue)
    }
}

extension BankViewController: IBankViewController {
    func initailInterface() {
        bankAccountView.isHidden = true
        coinImageView.isHidden = true
        historyView.isHidden = true
        expensesCollectionView.isHidden = true
        plusButton.isHidden = true
        activityIndicatorView.isHidden = false
    }
    
    func interfaceWithData() {
        self.setupBankAccountView()
        self.setupPlusButton()
        self.setupViewForCollection()
        self.setupCollectionView()
        bankAccountView.isHidden = false
        coinImageView.isHidden = false
        historyView.isHidden = false
        expensesCollectionView.isHidden = false
        plusButton.isHidden = false
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    func showAddExpenseAlert(expense: @escaping (ExpenseViewModel) -> ()) {
        let alert = CustomAlertController(title: AppTitle.Bank.newExpense, message: nil, preferredStyle: .alert)
        alert.addTextField { (valueTextField) in
            valueTextField.placeholder = "Bells"
            valueTextField.keyboardType = .decimalPad
            valueTextField.addAction(UIAction(handler: { _ in
                let count: Int = valueTextField.text?.count ?? 0
                if count != 0 {
                    alert.actions[0].isEnabled = true
                    alert.actions[1].isEnabled = true
                }
                if count == 0 {
                    alert.actions[0].isEnabled = false
                    alert.actions[1].isEnabled = false
                }
            }), for: .editingChanged)
        }
        
        let expenseAction = UIAlertAction(title: "Add Expense", style: .default) { _ in
            guard let valueTextField = alert.textFields?[0], let valueString = valueTextField.text, let valueInt = Int(valueString)
            else { return }
            let newExpense = ExpenseViewModel(value: valueInt, operationType: .minus)
            expense(newExpense)
        }
        
        let incomeAction = UIAlertAction(title: "Add Income", style: .default) { _ in
            guard let valueTextField = alert.textFields?[0], let valueString = valueTextField.text, let valueInt = Int(valueString)
            else { return }
            let newExpense = ExpenseViewModel(value: valueInt, operationType: .plus)
            expense(newExpense)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(expenseAction)
        alert.addAction(incomeAction)
        alert.addAction(cancelAction)
        expenseAction.isEnabled = false
        incomeAction.isEnabled = false
        self.present(alert, animated: true)
    }
    
    func refreshView(currentValue: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.expensesCollectionView.reloadData()
            self.currentAccountLabel.text = currentValue
        }
    }
}

extension BankViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.returnCollectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusibleID.expense.rawValue, for: indexPath) as? ExpenseCollectionViewCell else { return UICollectionViewCell() }
        let expenseItem = self.presenter.returnCollectionItem(index: indexPath.row)
        cell.colors = self.colors
        cell.customView = self.customView
        cell.config(item: expenseItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: AppContraints.Bank.collectionCellWidth, height: AppContraints.Bank.collectionCellHeight)
    }
}

@objc extension BankViewController {
	func plusButtonTapped(sender: UIButton) {
		self.presenter.plusButtonTapped()
	}
}
