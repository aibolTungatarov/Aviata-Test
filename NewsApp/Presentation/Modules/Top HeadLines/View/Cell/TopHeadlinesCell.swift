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

class TopHeadlinesCell: UITableViewCell {

    // MARK: - Views
    var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.placeholderImage.image
//        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel.bodyBold(24, lines: 0)
        label.textColor = .white
        label.text = "Beijing marketplace infections trigger 'wartime emergency mode' - ABC News"
        label.textAlignment = .center
        return label
    }()
    
    var overlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        return view
    }()
    
    // MARK: - Properties
    private(set) var article: Article?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
}

// MARK: - UI
extension TopHeadlinesCell {
    func configureViews() {
        selectionStyle = .none
        backgroundColor = .white
        
        thumbnailImageView.addSubview(overlay)
        [thumbnailImageView, titleLabel].forEach { contentView.addSubview($0) }
        configureConstraints()
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        let url = URL(string: article.urlToImage ?? "")
        thumbnailImageView.kf.setImage(with: url)
        self.article = article
    }

    func configureConstraints() {
        overlay.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
//            make.centerY.centerX.equalToSuperview()
            make.left.equalTo(thumbnailImageView).offset(25)
            make.right.equalTo(thumbnailImageView).offset(-25)
            make.top.equalTo(thumbnailImageView).offset(50)
            make.bottom.equalTo(thumbnailImageView).offset(-50)
        }
        
        thumbnailImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
