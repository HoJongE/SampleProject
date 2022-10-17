//
//  OpenWeatherService.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import Foundation

// API Call 프로토콜을 채택하는 Weahter API 를 선언
enum OpenWeatherAPI {
    case cityName(cityName: String)
}

extension OpenWeatherAPI: APICall {

    // OpenWeatherAPI enum 의 케이스마다 어떤 HTTP 메소드를 가지고 있는지?
    var method: HTTPMethod {
        switch self {
        case .cityName:
            return .get
        }
    }

    // OpenWeatherAPI enum 의 케이스마다 어떤 파라미터를 가지고 있는지?
    var parameters: Parameters {
        switch self {
        case .cityName(cityName: let cityName):
            return [
                "q": cityName,
                "appid": APIKey.apiKey
            ]
        }
    }

    var headers: Headers {
        switch self {
        case .cityName:
            return [:]
        }
    }

    var baseURL: String {
        return "https://api.openweathermap.org/"
    }

    var path: String {
        switch self {
        case .cityName:
            return "data/2.5/weather"
        }
    }

}
