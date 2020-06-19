//
//  TopAlignedCollectionViewFlowLayout.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

    attributes?
        .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
            guard $1.representedElementCategory == .cell else { return $0 }
            return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
            }
        }
        .values.forEach { minY, line in
            line.forEach {
                $0.frame = $0.frame.offsetBy(
                    dx: 0,
                    dy: minY - $0.frame.origin.y
                )
            }
        }

        return attributes
    }
}
