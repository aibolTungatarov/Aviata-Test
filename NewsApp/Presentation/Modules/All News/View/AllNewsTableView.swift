//
//  AllNewsTableView.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

class AllNewsTableView: UITableView {
    
    // MARK: - Properties
    
    // MARK: - Methods
    private func configure(with delegate: (UITableViewDataSource & UITableViewDelegate)?) {
        self.dataSource = delegate
        self.delegate = delegate
//        contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        backgroundColor = .white
        tableFooterView = UIView()
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = true
        contentInsetAdjustmentBehavior = .never
        contentInset = .zero
        scrollIndicatorInsets = .zero
        separatorStyle = .none
        register(cellClass: AllNewsCell.self)
    }
    
    // MARK: - Inits
    init(delegate: (UITableViewDataSource & UITableViewDelegate)?) {
        super.init(frame: .zero, style: .plain)
        configure(with: delegate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
