//
//  SavedArticlesViewController.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import CoreData

class SavedArticlesViewController: UIViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private lazy var tableView = SavedArticlesTableView(delegate: self)
    private(set) var viewModel: SavedArticlesViewModelProtocol
    private lazy var refreshControl = UIRefreshControl()
    var articles = [ArticleCoreData]()
    
    // MARK: - Views
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    // MARK: - Inits
    init(viewModel: SavedArticlesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.router.baseViewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension SavedArticlesViewController {
    
    func configureViews() {
        view.backgroundColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        [tableView].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.Roboto.medium.font(size: 20)!]
        title = "Saved Articles"
    }
}

// MARK: - Methods
extension SavedArticlesViewController {
    
    private func bind(to viewModel: SavedArticlesViewModelProtocol) {
        viewModel.articles.bind { articles in
             self.articles = articles
             self.tableView.reloadData()
         }.disposed(by: disposeBag)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        viewModel.reloadCoreData()
        tableView.reloadData()
    }
    
    func makeArticle(from articleCoreData: ArticleCoreData) -> Article {
        return Article(source: Source(id: Int(articleCoreData.sourceId ), name: articleCoreData.sourceName ?? ""),
                       author: articleCoreData.author ?? "",
                       title: articleCoreData.title ?? "",
                       description: articleCoreData.description ,
                       url: "",
                       urlToImage: articleCoreData.urlToImage ?? "",
                       publishedAt: articleCoreData.date ?? "",
                       content: articleCoreData.content ?? ""
        )
    }
}
