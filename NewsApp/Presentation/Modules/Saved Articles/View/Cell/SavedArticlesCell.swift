//
//  SavedArticlesTableViewCell.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class SavedArticlesCell: UITableViewCell {

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
        let label = UILabel.bodyBold(22, lines: 3)
        label.text = "Beijing marketplace infections trigger 'wartime emergency mode' - ABC News"
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel.hintMedium(15, lines: 1)
        label.text = "27.02.2020"
        return label
    }()
    
    var sourceLabel: UILabel = {
        let label = PaddingLabel(withInsets: 5, 5, 5, 5)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .white
        label.font = FontFamily.Roboto.medium.font(size: 12)
        label.backgroundColor = .appOrange
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.text = "Unknown"
        return label
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel.bodyRegular(14, lines: 0)
        label.text = "Unknown"
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
        
        [sourceLabel, authorLabel, titleLabel, thumbnailImageView, dateLabel].forEach { addSubview($0) }
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
            make.top.equalTo(authorLabel.snp.bottom).offset(3)
            make.left.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel)
//            make.width.equalTo(UIScreen.main.bounds.width / 3)
//            make.height.equalTo(thumbnailImageView.snp.width).dividedBy(1.3)
//            make.width.height.equalTo(UIScreen.main.bounds.width).dividedBy(4)
            make.width.equalTo(UIScreen.main.bounds.width / 4)
            make.height.equalTo(thumbnailImageView.snp.width)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(thumbnailImageView.snp.left).offset(-50)
            make.left.equalTo(titleLabel)
        }
    }
    
    func convertISODateToString(with ISOString: String) -> String {
        let date = ISOString.toISODate()?.toFormat("dd.MM.yyyy")
        return date ?? ""
    }
    
    func configure(with article: ArticleCoreData) {
        let sourceName = article.sourceName ?? "Unknown"
        titleLabel.text = article.title
        sourceLabel.text = sourceName.isEmpty ? "Unknown" : sourceName
        dateLabel.text = convertISODateToString(with: article.date ?? "")
        authorLabel.text = article.author ?? "Unknown"
        let url = URL(string: article.urlToImage ?? "")
        thumbnailImageView.kf.setImage(with: url)
    }
}
