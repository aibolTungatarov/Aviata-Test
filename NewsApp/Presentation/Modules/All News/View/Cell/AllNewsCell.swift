//
//  AllNewsCell.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class AllNewsCell: UITableViewCell {

    // MARK: - Views
    var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.placeholderImage.image
        view.layer.cornerRadius = 50
//        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var mainView = UIView()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Beijing marketplace infections trigger 'wartime emergency mode' - ABC News"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "27.02.2020"
        label.numberOfLines = 1
        return label
    }()
    
    var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "Youtube"
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Properties

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension SavedArticlesCell {
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .white
        
        [sourceLabel, titleLabel, thumbnailImageView, dateLabel].forEach { contentView.addSubview($0) }
        configureConstraints()
    }

    func configureConstraints() {
        sourceLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(sourceLabel.snp.bottom).offset(10)
            make.right.equalTo(thumbnailImageView.snp.left).offset(-10)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { (make) in
            make.right.centerY.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            make.height.equalTo(thumbnailImageView.snp.width).dividedBy(1.3)
        }
    }
    
    func convertISODateToString(with ISOString: String) -> String {
        let date = ISOString.toISODate()?.toFormat("dd.MM.yyyy")
        return date ?? ""
    }
}
