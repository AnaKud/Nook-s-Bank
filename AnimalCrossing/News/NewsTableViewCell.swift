//
//  NewsTableViewCell.swift
//  AnimalCrossing
//
//  Created by Anastasiya Kudasheva on 11.06.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    let backView = UIView()
    let dateView = UIView()
    let eventLabel = UILabel()
    var eventCircleView = UIView()
    let dateLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        self.setupLayout()
    }

    func config(withEvent event: EventsViewModel) {
        dateLabel.text = event.date
        eventLabel.text = event.event
        print(event.url)
        let firstCharacter: String = "\(event.type.first ?? "+")"
        eventCircleView = CustomViewController.makeCircleView(circleViewSize: AppContraints.News.circleViewSize, firstCharacter: firstCharacter)
        backView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(openURL(_: )) ))
    }

    private func setupLayout() {
        contentView.backgroundColor = .clear
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(AppContraints.News.cellBgEdge)
            make.trailing.equalTo(contentView).offset(-AppContraints.News.cellBgEdge)
            make.bottom.equalTo(contentView)
        }
        backView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
        backView.layer.cornerRadius = AppContraints.News.cellCornerRadius
        backView.layer.masksToBounds = true
        backView.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(backView)
            make.height.equalTo(AppContraints.News.dateViewHeight)
        }
        dateView.backgroundColor = #colorLiteral(red: 0.3490196078, green: 0.4352941176, blue: 0.6823529412, alpha: 1)
        dateView.addSubview(eventCircleView)
        eventCircleView.snp.makeConstraints { make in
            make.leading.equalTo(dateView).offset(AppContraints.News.cellBgEdge)
            make.centerY.equalTo(dateView)
            make.height.width.equalTo(AppContraints.News.circleViewSize)
        }
        dateView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(eventCircleView.snp.trailing).offset(AppContraints.News.cellBgEdge)
            make.trailing.equalTo(dateView).offset(-AppContraints.News.cellBgEdge)
            make.top.equalTo(dateView).offset(AppContraints.News.cellBgEdge)
            make.bottom.equalTo(dateView).offset(-AppContraints.News.cellBgEdge)
        }
        dateLabel.font = UIFont(name: AppFont.maruBold.rawValue, size: 20)
        dateLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.8901960784, alpha: 1)
        backView.addSubview(eventLabel)
        eventLabel.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(AppContraints.News.cellBgEdge)
            make.leading.equalTo(backView).offset(AppContraints.News.cellBgEdge)
            make.trailing.bottom.equalTo(backView).offset(-AppContraints.News.cellBgEdge)
            make.height.greaterThanOrEqualTo(40)
        }
        eventLabel.numberOfLines = 0
        eventLabel.font = UIFont(name: AppFont.maruLight.rawValue, size: 20)
        eventLabel.textColor =  #colorLiteral(red: 0.5137254902, green: 0.4823529412, blue: 0.4588235294, alpha: 1)
    }
    
    @objc func openURL(_ sender: UITapGestureRecognizer) {
        print("Tapped cell")
    }
}
