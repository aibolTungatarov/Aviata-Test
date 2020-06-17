//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SwiftDate

class NewsDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: NewsDetailViewModelProtocol
    private var isFavorite = false {
        didSet {
            favoritesButton.setImage(self.isFavorite ? Asset.starFilledImage.image : Asset.starImage.image, for: .normal)
        }
    }
    
    // MARK: - Views
    private var thumbnailImageView: UIImageView = {
        let view = UIImageView()
        view.image = Asset.placeholderImage.image
//        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.backImage.image, for: .normal)
        return button
    }()
    
    private var favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.starImage.image, for: .normal)
        return button
    }()
    
    private var authorLabel: UILabel = {
        let label = UILabel.bodyMedium(15, lines: 0)
        return label
    }()
    
    private var sourceLabel: UILabel = {
        let label = UILabel.bodyRegular(15, lines: 0)
        label.text = "Unknown"
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel.hintRegular(15, lines: 0)
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel.bodyBold(20, lines: 0)
        return label
    }()
    
    private var separatorView = UIView()
    
    private var contentLabel: UILabel = {
        let label = UILabel.bodyRegular(16, lines: 0)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Inits
    init(viewModel: NewsDetailViewModelProtocol, article: Article?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.router.baseViewController = self
        configure(with: article)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension NewsDetailViewController {
    
    func configureViews() {
        view.backgroundColor = .white
        separatorView.backgroundColor = .hint
        [thumbnailImageView, titleLabel, sourceLabel, dateLabel, contentLabel, authorLabel, separatorView, backButton, favoritesButton].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    func configureConstraints() {
        thumbnailImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width / 1.5)
        }
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sourceLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(titleLabel)
        }
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorView.snp.bottom).offset(15)
            make.left.right.equalTo(titleLabel)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
        }
        favoritesButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
    }
}

// MARK: - Methods
extension NewsDetailViewController {
    
    private func bind(to viewModel: NewsDetailViewModelProtocol) {
        backButton.rx.tap.bind {
            viewModel.goBack()
        }.disposed(by: disposeBag)
        
        favoritesButton.rx.tap.bind {
            self.isFavorite = !self.isFavorite
        }.disposed(by: disposeBag)
    }
    
    func configure(with article: Article?) {
        let url = URL(string: article?.urlToImage ?? "")
        thumbnailImageView.kf.setImage(with: url)
        sourceLabel.text = article?.source?.name ?? "Unknown"
        dateLabel.text = convertISODateToString(with: article?.publishedAt ?? "")
        titleLabel.text = article?.title
        contentLabel.text = article?.content
        authorLabel.text = "author: " + (article?.author ?? "Unknown")
    }
    
    func convertISODateToString(with ISOString: String) -> String {
        let date = ISOString.toISODate()?.toFormat("dd.MM.yyyy")
        return date ?? ""
    }
    
}
