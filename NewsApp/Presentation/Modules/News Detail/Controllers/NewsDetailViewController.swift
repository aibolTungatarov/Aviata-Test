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
import CoreData

class NewsDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: NewsDetailViewModelProtocol
    private var isFavorite = false {
        didSet {
            favoritesButton.setImage(self.isFavorite ? Asset.starFilledImage.image : Asset.starImage.image, for: .normal)
        }
    }
    private let article: Article?
    private let context = AppDelegate.viewContext
//    private var articlesCoreData = [ArticleCoreData]()
    private var articleCoreData: ArticleCoreData?
    
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
        self.article = article
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
            self.changeCoreData(self.isFavorite)
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
        checkIsFav()
    }
    
    func convertISODateToString(with ISOString: String) -> String {
        let date = ISOString.toISODate()?.toFormat("dd.MM.yyyy")
        return date ?? ""
    }
    
    func changeCoreData(_ isFav: Bool) {
        if isFav {
            saveData()
        } else {
            removeData()
        }
    }
    
    func saveData() {
        let article = makeArticleCoreData()
        self.articleCoreData = article
        self.saveContext()
    }
    
    func removeData() {
        let article = makeArticleCoreData()
        self.context.delete(article)
//        articlesCoreData.removeAll { return $0 == article }
        self.articleCoreData = nil
        saveContext()
    }
    
    func makeArticleCoreData() -> ArticleCoreData {
        let article = ArticleCoreData(context: self.context)
        if let articleData = self.article {
            article.author = articleData.author
            article.content = articleData.content
            article.date = articleData.publishedAt
            article.desc = articleData.description
            article.sourceId = Int16(articleData.source?.id ?? 0)
            article.sourceName = articleData.source?.name
            article.urlToImage = articleData.urlToImage
            article.title = articleData.title
        }
        return article
    }
    
    func checkIsFav() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleCoreData")
        let sourceNamePredicate = NSPredicate(format: "sourceName == %@", article?.source?.name ?? "")
        let sourceIdPredicate = NSPredicate(format: "sourceId == %@", Int16(article?.source?.id ?? 0))
        let authorPredicate = NSPredicate(format: "author == %@", article?.author ?? "")
        let titlePredicate = NSPredicate(format: "title == %@", article?.title ?? "")
        let descriptionPredicate = NSPredicate(format: "desc == %@", article?.description ?? "")
        let urlToImagePredicate = NSPredicate(format: "urlToImage == %@", article?.urlToImage ?? "")
        let datePredicate = NSPredicate(format: "date == %@", article?.publishedAt ?? "")
        let contentPredicate = NSPredicate(format: "content == %@", article?.content ?? "")
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [sourceNamePredicate,sourceIdPredicate, authorPredicate, titlePredicate, descriptionPredicate, urlToImagePredicate, datePredicate, contentPredicate])

        request.predicate = predicateCompound
        request.fetchLimit = 1

        do {
//            let app = UIApplication.shared.delegate as! AppDelegate
//            let context = app.managedObjectContext
            let count = try context.count(for: request)
            if(count == 0) {
                // no matching object
                print("no present")
                self.isFavorite = false
            }
            else{
                // at least one matching object exists
                print("one matching item found")
                self.isFavorite = true
                let article = makeArticleCoreData()
                self.articleCoreData = article
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            
        }
    }
    
}
