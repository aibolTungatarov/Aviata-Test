//
//  UILabelExtensions.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/15/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

extension UILabel {
    
    // MARK: - spacingValue is spacing that you need
    func lineSpacing(_ spacingValue: CGFloat = 2) {

        guard let textString = text else { return }
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
        ))
        attributedText = attributedString
    }
    
    // MARK: - Highlight Label
    
    static func hintRegular(_ fontSize: CGFloat, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = lines
        label.textColor = .hint
        label.font = FontFamily.Roboto.regular.font(size: fontSize)
        return label
    }
    
    static func hintMedium(_ fontSize: CGFloat, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = lines
        label.textColor = .hint
        label.font = FontFamily.Roboto.medium.font(size: fontSize)
        return label
    }
    
    static func bodyRegular(_ fontSize: CGFloat, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = lines
        label.textColor = .appBlack
        label.font = FontFamily.Roboto.regular.font(size: fontSize)
        return label
    }
    
    static func bodyMedium(_ fontSize: CGFloat, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = lines
        label.textColor = .appBlack
        label.font = FontFamily.Roboto.medium.font(size: fontSize)
        return label
    }
    
    static func bodyBold(_ fontSize: CGFloat, lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = lines
        label.textColor = .appBlack
        label.font = FontFamily.Roboto.bold.font(size: fontSize)
        return label
    }

}
