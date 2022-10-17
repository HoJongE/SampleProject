//
//  URLSession+rx.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import RxSwift
import Foundation

enum RxURLError: Error {
    case unknown
    case badResponse
    case badURL
}

extension Reactive where Base: URLSession {
    func response(_ request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        // 기존 completion Handler 만 제공되는 API 에 Rx Extension 을 내 마음대로 추가할 수 있다!
        // 자세한 건 Observable 생성 부분을 공부하세요
        return Observable.create { observer in

            let task = base.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }

                guard let data, let response = response as? HTTPURLResponse else {
                    observer.onError(RxURLError.unknown)
                    return
                }

                observer.onNext((response, data))
                observer.onCompleted()
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }

    // 기존 response, data 형태로 반환되던 Observable 을 그대로 받아서 data 만 내보내도록 변환함
    func data(_ request: URLRequest) -> Observable<Data> {
        return response(request)
            .map { (response, data) -> Data in
                guard 200..<300 ~= response.statusCode else {
                    throw RxURLError.badResponse
                }
                return data
            }
    }

    // data 옵저버블을 그대로 받아서, json Dictionary 형태로 변환함
    func json(_ request: URLRequest) -> Observable<[String: Any]> {
        return data(request)
            .map { data in
                try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] ?? [:]
            }
    }

    // data Observable 을 그대로 받아서, Decodable 프로토콜을 채택한 타입으로 변환함
    func decodable<T: Decodable>(_ request: URLRequest, type: T.Type) -> Observable<T> {
        return data(request)
            .do(onNext: {
                print(String(data: $0, encoding: .utf8))
            })
            .map { data in
                try JSONDecoder().decode(type, from: data)
            }
    }
}
