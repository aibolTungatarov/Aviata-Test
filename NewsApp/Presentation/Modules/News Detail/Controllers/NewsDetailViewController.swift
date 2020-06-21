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
    private var article: Article
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
//        let image = Asset.backImage.image.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        let image = Asset.backImage.image.maskWithColor(color: .white)
//        let image = Asset.backImage.image
        button.setImage(image, for: .normal)
        return button
    }()
    
    private var favoritesButton: UIButton = {
        let button = UIButton()
//        let image = Asset.starImage.image.withRenderingMode(.alwaysTemplate).withTintColor(.white)
        let image = Asset.starImage.image.maskWithColor(color: .white)
//        let image = Asset.starImage.image
        button.setImage(image, for: .normal)
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
    
    private var overlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Inits
    init(viewModel: NewsDetailViewModelProtocol, article: Article?) {
        self.viewModel = viewModel
        self.article = article ?? Article()
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.router.baseViewController = self
        configure(with: self.article)
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
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        [overlay].forEach { thumbnailImageView.addSubview($0) }
        [thumbnailImageView, titleLabel, sourceLabel, dateLabel, contentLabel, authorLabel, separatorView,  backButton, favoritesButton].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    func configureConstraints() {
        overlay.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalTo(70)
            make.edges.equalToSuperview()
        }
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
            make.right.lessThanOrEqualTo(dateLabel.snp.left)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalTo(titleLabel)
//            make.left.equalTo(authorLabel.snp.right)
        }
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(authorLabel.snp.bottom).offset(15)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorView.snp.bottom).offset(15)
            make.left.right.equalTo(titleLabel)
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
        }
        favoritesButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
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
    
    func configure(with article: Article) {
        let url = URL(string: article.urlToImage ?? "")
        thumbnailImageView.kf.setImage(with: url)
        sourceLabel.text = article.source?.name ?? "Unknown"
        dateLabel.text = convertISODateToString(with: article.publishedAt ?? "")
        titleLabel.text = article.title
        contentLabel.text = article.content
        authorLabel.text = "author: " + (article.author ?? "Unknown")
        checkIsFav(with: article)
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
//        let article = makeArticleCoreData()
        if let articleCoreData = articleCoreData {
            self.context.delete(articleCoreData)
            self.articleCoreData = nil
            saveContext()
        }
    }
    
    func makeArticleCoreData() -> ArticleCoreData {
        let article = ArticleCoreData(context: self.context)
        let articleData = self.article
        article.author = articleData.author
        article.content = articleData.content
        article.date = articleData.publishedAt
        article.desc = articleData.description
        article.sourceId = Int16(articleData.source?.id ?? 0)
        article.sourceName = articleData.source?.name ?? ""
        article.urlToImage = articleData.urlToImage
        article.title = articleData.title
        return article
    }
    
    func checkIsFav(with article: Article) {
//        let source = (article.source ?? Source())
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleCoreData")
//        let sourceNamePredicate = NSPredicate(format: "sourceName == %@", source.name ?? "")
//        let sourceIdPredicate = NSPredicate(format: "sourceId == %@", source.id ?? 0)
        let authorPredicate = NSPredicate(format: "author == %@", article.author ?? "")
        let titlePredicate = NSPredicate(format: "title == %@", article.title ?? "")
        let descriptionPredicate = NSPredicate(format: "desc == %@", article.description ?? "")
//        let urlToImagePredicate = NSPredicate(format: "urlToImage == %@", article.urlToImage ?? "")
        let datePredicate = NSPredicate(format: "date == %@", article.publishedAt ?? "")
//        let contentPredicate = NSPredicate(format: "content == %@", article.content ?? "")
//        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [authorPredicate, titlePredicate, descriptionPredicate, urlToImagePredicate, datePredicate, contentPredicate])
        
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [titlePredicate, descriptionPredicate, datePredicate, authorPredicate])
        request.predicate = predicateCompound
        request.fetchLimit = 1

        do {
//            let app = UIApplication.shared.delegate as! AppDelegate
//            let context = app.managedObjectContext
            let count = try self.context.count(for: request)
            if(count == 0) {
                // no matching object
                print("no present")
                self.isFavorite = false
            }
            else{
                // at least one matching object exists
                print("one matching item found")
                self.isFavorite = true
                fetchData()
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
    
    func fetchData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleCoreData")
        let authorPredicate = NSPredicate(format: "author == %@", article.author ?? "")
        let titlePredicate = NSPredicate(format: "title == %@", article.title ?? "")
        let descriptionPredicate = NSPredicate(format: "desc == %@", article.description ?? "")
        let datePredicate = NSPredicate(format: "date == %@", article.publishedAt ?? "")
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [titlePredicate, descriptionPredicate, datePredicate, authorPredicate])
        
        request.predicate = predicateCompound
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if (result.count == 1) {
                self.articleCoreData = result.first as? ArticleCoreData
            }
            
        } catch {
            print("Failed")
        }
    }
    
}
