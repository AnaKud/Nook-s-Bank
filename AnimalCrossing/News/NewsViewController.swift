//
//  NewsViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import UIKit
import SnapKit

protocol INewsViewController {
    func displayActivity()
    func displayTable()
    func refreshView()
}

class NewsViewController: CustomViewController {
    var presenter: INewsPresenter
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView()
    
    init(presenter: INewsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func loadView() {
        super.loadView()
        self.setupNavBar()
        self.presenter.loadView(view: self)
        self.presenter.makeRequest()
        
        self.setupTable()
        
       
    }
    
    private func setupNavBar() {
        
        
//        let backImage = UIImage(systemName: AppImage.Login.iconForEmailTF.rawValue)
//
//        switch userStatus {
//        case .loggined:
//            backImage?.withTintColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, image: nil, primaryAction: nil, menu: nil)
//            self.navigationController?.navigationBar.backItem?.title = "Log Out"
//        case .unloggined:
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, image: nil, primaryAction: nil, menu: nil)
//            backImage?.withTintColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
//            self.navigationController?.navigationBar.backItem?.title = "Log In"
//        default:
//            backImage?.withTintColor(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
//            self.navigationController?.navigationBar.backItem?.title = ""
//        }
//        self.navigationController?.navigationBar.backIndicatorImage = backImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
    private func setupTable(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: CellReusibleID.news.rawValue)
        self.tableView.allowsSelection = false
    }
    
    func displayActivity() {
        self.tableView.isHidden = true
        self.contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }
        self.activityIndicator.style = .large
        switch userStatus {
        case .loggined:
            self.activityIndicator.color = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
        default:
            self.activityIndicator.color = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        }
        
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        
    }
    
    func displayTable() {
        DispatchQueue.main.async {
            
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.contentView.addSubview(self.tableView)
            self.tableView.snp.makeConstraints { make in
                make.edges.equalTo(self.contentView)
            }
            self.tableView.separatorStyle = .none
            self.tableView.backgroundColor = .clear
            self.tableView.isHidden = false
        }
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.cellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReusibleID.news.rawValue) as? NewsTableViewCell else { return UITableViewCell() }
        let event = self.presenter.itemForCell(index: indexPath.row)
        cell.config(withEvent: event)
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReusibleID.news.rawValue) as? NewsTableViewCell else { return }
//        let event = self.presenter.itemForCell(index: indexPath.row)
//        guard let url = URL(string: event.url) else { return }
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    }
    
    
}

extension NewsViewController: INewsViewController {
    func refreshView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tableView.reloadData()
        }
    }
}

