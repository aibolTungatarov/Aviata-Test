//
//  UITableViewExtensions.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: - Methods
    func register(cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: "\(cellClass)")
    }
    
    func register(aClass: AnyClass) {
        register(aClass, forHeaderFooterViewReuseIdentifier: "\(aClass)")
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else { fatalError() }
        
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as? T else { fatalError() }
        
        return view
    }
     
    func isFloatingSectionHeader(view: UITableViewHeaderFooterView) -> Bool {
        if let section = section(for: view) {
            return isFloatingHeaderInSection(section: section)
        }
        return false
      }

     func isFloatingHeaderInSection(section: Int) -> Bool {
         let frame = rectForHeader(inSection: section)
         let offsetY = contentInset.top + contentOffset.y
         return offsetY > frame.origin.y
     }

     func section(for view: UITableViewHeaderFooterView) -> Int? {
         for index in stride(from: 0, to: numberOfSections, by: 1) {
             let boundsA = convert(CGPoint.zero, from:headerView(forSection: index))
             let boundsB = convert(CGPoint.zero, from: view)
             if boundsA.y == boundsB.y {
                 return index
             }
         }
         return nil
     }
}
