//
//  NewsViewController.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import SnapKit
import UIKit

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
       // self.navDelegate = presenter
        self.presenter.loadView(view: self)
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.setupTable()
        self.displayActivity()
    }

    private func setupTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: CellReusibleID.news.rawValue)
    }

    func displayActivity() {
        self.tableView.isHidden = true
        self.contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }
        self.activityIndicator.style = .large
        self.activityIndicator.color = colors?.activityIndicatorColor.activityColor

        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }

    func displayTable() {
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

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.cellCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
														CellReusibleID.news.rawValue)
				as? NewsTableViewCell else { return UITableViewCell() }
        let event = self.presenter.itemForCell(index: indexPath.row)
        cell.colors = self.colors
        cell.customView = self.customView
        cell.config(withEvent: event)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.cellPressed(index: indexPath.row)
    }
}

extension NewsViewController: INewsViewController {
    func refreshView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.tableView.reloadData()
        }
    }
}
