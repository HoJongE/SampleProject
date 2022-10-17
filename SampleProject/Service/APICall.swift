//
//  APICall.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

typealias Parameters = [String: String]
typealias Headers = [String: String]

import RxSwift
import Foundation

enum HTTPMethod: String {
    case get = "get"
    case post = "post"
    case delete = "delete"
}

protocol APICall {
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    var headers : Headers { get }
    var baseURL: String { get }
    var path: String { get }
}

// API Call 프로토콜의 기본 구현 코드
// API Call 프로토콜을 채택하는 모든 구현타입이 사용 가능한 코드임
extension APICall {

    private var url: URL? {
        var urlComponents: URLComponents? = URLComponents(string: baseURL + path)
        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }

    private var request: URLRequest? {
        guard let url else { return nil }
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }

    func response() -> Observable<(response: HTTPURLResponse, data: Data)> {
        guard let request else { return Observable.error(RxURLError.badURL) }
        return URLSession.shared.rx.response(request)
    }

    func data() -> Observable<Data> {
        guard let request else { return Observable.error(RxURLError.badURL) }
        return URLSession.shared.rx.data(request)
    }

    func json() -> Observable<[String: Any]> {
        guard let request else { return Observable.error(RxURLError.badURL) }
        return URLSession.shared.rx.json(request)
    }

    func decodable<T: Decodable>(type: T.Type) -> Observable<T> {
        guard let request else { return Observable.error(RxURLError.badURL) }
        return URLSession.shared.rx
            .decodable(request, type: type)
    }
}


