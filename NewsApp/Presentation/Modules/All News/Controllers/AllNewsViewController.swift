//
//  MainViewController.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AllNewsViewController: UIViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private lazy var collectionView = AllNewsCollectionView(delegate: self)
    private(set) var viewModel: AllNewsViewModelProtocol
    private lazy var refreshControl = UIRefreshControl()
//    private(set) var news: News?
    var articles = [Article]()
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
    init(viewModel: AllNewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.router.baseViewController = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension AllNewsViewController {
    
    func configureViews() {
        view.backgroundColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        collectionView.addSubview(refreshControl)
        [collectionView].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    func configureConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: FontFamily.Roboto.medium.font(size: 20)!]
        title = "All News"
    }
}

// MARK: - Methods
extension AllNewsViewController {
    
    private func bind(to viewModel: AllNewsViewModelProtocol) {
        viewModel.news.bind { newsList in
            self.articles += newsList.articles
            self.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
    
}
