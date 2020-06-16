//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/14/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import RxAlamofire
import RxSwift
import Reachability
import Alamofire
import Foundation

protocol NetworkManagerProtocol: class {

    func getConfiguredRequest(_ request: URLRequest, url: URL, method: HTTPMethod, parameters: Parameters?) -> URLRequest
    func send(request: URLRequest) -> Observable<DataResponse<Any>>
    func request(_ url: URL,
                 method: HTTPMethod,
                 headers: HTTPHeaders?,
                 parameters: Parameters?,
                 timeoutInterval: TimeInterval) -> Observable<DataResponse<Any>>

}

extension NetworkManagerProtocol {

    func request(_ url: URL,
                 method: HTTPMethod,
                 headers: HTTPHeaders? = nil,
                 parameters: Parameters? = nil,
                 timeoutInterval: TimeInterval = 60) -> Observable<DataResponse<Any>> {
        return request(url, method: method, headers: headers, parameters: parameters, timeoutInterval: timeoutInterval)
    }

}

class NetworkManager: NetworkManagerProtocol {

    // MARK: - Properties
    static let shared: NetworkManagerProtocol = NetworkManager()
    let disposeBag = DisposeBag()

    // MARK: - Methods
    func getConfiguredRequest(_ request: URLRequest, url: URL, method: HTTPMethod, parameters: Parameters?) -> URLRequest {
        var configuredRequest = request
        if let parameters = parameters {
            do {
                switch method {
                case .get: configuredRequest = try URLEncoding.default.encode(request, with: parameters)
                default: configuredRequest = try JSONEncoding.default.encode(request, with: parameters)
                }
            } catch { }
        }

        return configuredRequest
    }

    private func getRequest(url: URL,
                            method: HTTPMethod,
                            headers: HTTPHeaders?,
                            parameters: Parameters?,
                            timeoutInterval: TimeInterval) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval
        (headers ?? [:]).forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
//        if let token = UserSessionManager.shared.token {
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }

        return getConfiguredRequest(request, url: url, method: method, parameters: parameters)
    }

    private func printResponse(_ response: DataResponse<Any>) {
        guard Constants.debugNetwork else { return }

        for _ in 0..<10 { print() }
        for _ in 0..<150 { print("-", separator: "", terminator: "") }
        print()
        print("[Headers]: \(response.request?.allHTTPHeaderFields ?? [:])")
        print("[Request]: \(response.request?.httpMethod ?? "") \(response.response?.url?.absoluteString ?? "")")
        if let data = response.request?.httpBody {
            do {
                print("[Parameters]: \(try JSONSerialization.jsonObject(with: data))")
            } catch {
                print("[Parameters]: \([:])")
            }
        } else {
            print("[Parameters]: \([:])")
        }

        if let data = response.data {
            if let object = try? JSONSerialization.jsonObject(with: data, options: []),
                let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                let dataString = String(data: data, encoding: .utf8) {
                print("[Result]: \(dataString)")
            } else if let data = response.data,
                let dataString = String(data: data, encoding: .utf8) {
                print("[Result]: \(dataString)")
            }
        }

        for _ in 0..<150 { print("-", separator: "", terminator: "") }
        for _ in 0..<10 { print() }
    }

    func send(request: URLRequest) -> Observable<DataResponse<Any>> {
        guard let connection = try? Reachability().connection, !(connection == .unavailable) else {
            return Observable.error(APIError.noConnection.toNSError())
        }

        return RxAlamofire.request(request).responseJSON()
    }

    func request(_ url: URL,
                 method: HTTPMethod,
                 headers: HTTPHeaders?,
                 parameters: Parameters?,
                 timeoutInterval: TimeInterval) -> Observable<DataResponse<Any>> {
        let request = getRequest(url: url,
                                 method: method,
                                 headers: headers,
                                 parameters: parameters,
                                 timeoutInterval: timeoutInterval)
        print("REQUEST URL ", request.url as Any)
        return send(request: request)
    }

}
