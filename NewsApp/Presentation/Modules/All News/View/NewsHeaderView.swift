//
//  NewsHeaderView.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

class NewsHeaderView: UICollectionReusableView {
    
    // MARK: - Views
    var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.placeholderImage.image
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel.bodyMedium(23, lines: 0)
        label.text = "Beijing marketplace infections trigger 'wartime emergency mode' - ABC News"
        label.textAlignment = .center
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel.hintRegular(16)
        label.textAlignment = .center
        label.text = "27.02.2020"
        return label
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
extension NewsHeaderView {
    
}

// MARK: - Methods
extension NewsHeaderView {
    
    private func configureViews() {
        [titleLabel, dateLabel, thumbnailImageView].forEach { addSubview($0) }
        configureConstraints()
    }
    
    private func configureConstraints() {
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.width.height.equalTo(UIScreen.main.bounds.width - 100)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(thumbnailImageView)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
    }
}
