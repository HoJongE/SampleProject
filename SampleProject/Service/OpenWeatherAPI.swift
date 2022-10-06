//
//  OpenWeatherService.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import Foundation

enum OpenWeatherAPI {
    case cityName(cityName: String)
}

extension OpenWeatherAPI: APICall {

    var method: HTTPMethod {
        switch self {
        case .cityName:
            return .get
        }
    }

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
