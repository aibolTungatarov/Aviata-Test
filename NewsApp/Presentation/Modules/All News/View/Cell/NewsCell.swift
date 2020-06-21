//
//  NewsCell.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import SwiftDate

//protocol TagCellDelegate: class {
//    func tagCell(_ view: TagCell, didTapTag label: UILabel)
//}

class NewsCell: UICollectionViewCell {
    
    // MARK: - Views
    var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        let image = Asset.placeholderImage.image
        view.image = image
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true

//        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var mainView = UIView()
    
    var titleLabel: UILabel = {
        let label = UILabel.bodyBold(20, lines: 3)
        label.lineBreakMode = .byTruncatingTail
        label.text = "Beijing marketplace infections trigger 'wartime emergency mode' - ABC News"
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel.hintRegular(14, lines: 0)
        label.text = "27.02.2020"
        return label
    }()
    
    // MARK: - Parameters
//    weak var delegate: TagCellDelegate?
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Methods
extension NewsCell {
    
    private func configureViews() {
//        addSubview(mainView)
        [titleLabel, thumbnailImageView, dateLabel].forEach { contentView.addSubview($0) }
        configureConstraints()
    }
    
    private func configureConstraints() {
//        mainView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//            make.width.equalTo((UIScreen.main.bounds.width - 100 - 25) / 2)
//        }
        
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.width.equalTo((UIScreen.main.bounds.width - 100 - 25) / 2)
            make.height.equalTo(70)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(thumbnailImageView)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(thumbnailImageView)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    
    func configure(with article: Article?) {
        titleLabel.text = article?.title
        dateLabel.text = convertISODateToString(with: article?.publishedAt ?? "")
        let url = URL(string: article?.urlToImage ?? "")
        thumbnailImageView.kf.setImage(with: url)
    }
    
    func convertISODateToString(with ISOString: String) -> String {
        let date = ISOString.toISODate()?.toFormat("dd.MM.yyyy")
        return date ?? ""
    }
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        contentView.snp.makeConstraints { (make) in
//            make.width.equalTo(bounds.size.width)
//        }
////        width.constant = bounds.size.width
//        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
//    }
}
