//
//  MainCollectionView.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

class MainCollectionView: UICollectionView {
    
    // MARK: - Inits
    init(delegate: (UICollectionViewDataSource & UICollectionViewDelegate)?) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.delegate = delegate
        self.dataSource = delegate
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = true
        contentInset = .zero
        contentOffset = .zero
        allowsMultipleSelection = true
        register(cellClass: NewsCell.self)
        register(aClass: NewsHeaderView.self)
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: 50)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
}
