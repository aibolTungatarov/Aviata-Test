//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import SwiftyJSON
import Alamofire

public class NewsRepository: NewsRepositoryProtocol {
    
    public init() { }
    
    // MARK: - Methods
    public func getTopHeadlines(query: String) -> Observable<News> {
        var headers: HTTPHeaders = [String: String]()
        let params = ["q": query]
        let apiKey = Constants.apiKey
        headers["Authorization"] = "Bearer \(apiKey)"
        return NetworkManager.shared.request(URL.topHeadlines, method: .get, headers: headers, parameters: params)
            .debug()
            .flatMap { response -> Observable<JSON> in
                 switch response.result {
                 case .success(let data):
                     let json = JSON(data)
                     
                     if json.isEmpty {
                        return .error(APIError.badResposne.toNSError())
                     }
                     
                     let status = json["status"].stringValue
                     if status == "ok" {
                        return .just(json)
                     }
                     else {
                        return .error(APIError.toNSError(with: json["message"].stringValue))
                     }
                 case .failure(let error):
                     return .error(error)
                 }
            }
            .map { return NewsMapper().from($0) }
    }
    
    public func getEverything(query: String) -> Observable<News> {
        var headers: HTTPHeaders = [String: String]()
        let apiKey = Constants.apiKey
        headers["Authorization"] = "Bearer \(apiKey)"
        let params = ["q": query]
        return NetworkManager.shared.request(URL.everything, method: .get, headers: headers, parameters: params)
            .debug()
            .flatMap { response -> Observable<JSON> in
                 switch response.result {
                 case .success(let data):
                     let json = JSON(data)
//
                     if json.isEmpty {
                        return .error(APIError.badResposne.toNSError())
                     }
                     
                     let status = json["status"].stringValue
                     if status == "ok" {
                        return .just(json)
                     }
                     else {
                        return .error(APIError.toNSError(with: json["message"].stringValue))
                     }
                 case .failure(let error):
                     return .error(error)
                 }
            }
            .map { return NewsMapper().from($0) }
    }
}
