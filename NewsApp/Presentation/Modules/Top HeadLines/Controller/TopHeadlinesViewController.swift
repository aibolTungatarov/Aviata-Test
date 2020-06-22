//
//  AllNewsViewController.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TopHeadlinesViewController: UIViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private lazy var tableView = TopHeadlinesTableView(delegate: self)
    private(set) var viewModel: TopHeadlinesViewModelProtocol
//    private(set) var news: News?
    private(set) var articles = [Article]()
    var page = 1
    var pageSize = 20
    
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
    init(viewModel: TopHeadlinesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.router.baseViewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension TopHeadlinesViewController {
    
    func configureViews() {
        view.backgroundColor = .white
        [tableView].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.Roboto.medium.font(size: 20)!]
//        let attributes = [NSAttributedString.Key.font: FontFamily.Roboto.regular.font(size: 10)!]
//        UINavigationBar.appearance().titleTextAttributes = attributes
        title = "Top Headlines"
    }
}

// MARK: - Methods
extension TopHeadlinesViewController {
    
    private func bind(to viewModel: TopHeadlinesViewModelProtocol) {
        viewModel.news.bind { news in
            self.articles += news.articles
            self.tableView.reloadData()
         }.disposed(by: disposeBag)
    }
    
}
