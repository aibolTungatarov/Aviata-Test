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

class SavedArticlesViewController: UIViewController {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private lazy var tableView = SavedArticlesTableView(delegate: self)
    private var viewModel: SavedArticlesViewModelProtocol
    
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
        [tableView].forEach { view.addSubview($0) }
        configureConstraints()
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Saved Articles"
    }
}

// MARK: - Methods
extension SavedArticlesViewController {
    
    private func bind(to viewModel: SavedArticlesViewModelProtocol) {
//        viewModel.news.bind { news in
//             self.news = news
//             self.tableView.reloadData()
//         }.disposed(by: disposeBag)
    }
    
}
