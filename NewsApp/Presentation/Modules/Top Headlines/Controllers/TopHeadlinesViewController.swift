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

class TopHeadlinesViewController: UIViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private lazy var collectionView = TopHeadlinesCollectionView(delegate: self)
    private(set) var viewModel: TopHeadlinesViewModelProtocol
    private(set) var news: News?
    
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
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        [collectionView].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    func configureConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top News"
    }
}

// MARK: - Methods
extension TopHeadlinesViewController {
    
    private func bind(to viewModel: TopHeadlinesViewModelProtocol) {
        viewModel.news.bind { newsList in
//            var insertList = [Int]()
//            var deleteList = [Int]()
//            let articles = self.news?.articles ?? []
//            for i in 0..<articles.count{
//                let article = articles[i]
//                if (!(newsList.articles.contains(where: { return $0 == article }) )) {
//                    deleteList.append(i)
//                }
//            }
//
//            for i in 0..<deleteList.count {
//                self.news?.articles.remove(at: i)
//            }
//
//            let newArticles = newsList.articles
//            let oldArticles = self.news?.articles ?? []
//            for i in 0..<newArticles.count{
//                let article = newArticles[i]
//                if (!(oldArticles.contains(where: { return $0 == article }) )) {
//                    insertList.append(i)
//                }
//            }
//
//            for i in 0..<insertList.count {
//                self.news?.articles.append(newArticles[i])
//            }
//
//            self.collectionView.performBatchUpdates({
//
//            })
            self.news = newsList
            self.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
}
