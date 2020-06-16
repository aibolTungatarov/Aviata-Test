//
//  UICollectionViewExtensions.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: - Methods
    func register(cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: "\(cellClass)")
    }
    
    func register(aClass: AnyClass) {
        register(aClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(aClass)")
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T else { fatalError() }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UICollectionReusableView>(_ kind: String, indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(T.self)", for: indexPath) as? T else { fatalError() }

        return view
    }
}
