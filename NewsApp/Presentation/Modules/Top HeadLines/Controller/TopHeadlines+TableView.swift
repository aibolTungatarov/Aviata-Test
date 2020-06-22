//
//  AllNews+TableView.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/17/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

extension TopHeadlinesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopHeadlinesCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UIScreen.main.bounds.width / 1.5)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension TopHeadlinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.goToDetail(with: articles[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == articles.count - 1) {
            page += 1
            viewModel.loadNews(at: page)
        }
    }
}
