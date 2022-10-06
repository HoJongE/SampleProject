//
//  OpenWeatherService.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import RxSwift
import Foundation

protocol WeatherService: AnyObject {
    func weatherOfCity(_ cityName: String) -> Observable<WeatherDAO>
}
final class OpenWeatherService {
    static let shared: WeatherService = OpenWeatherService()
}

extension OpenWeatherService: WeatherService {

    func weatherOfCity(_ cityName: String) -> Observable<WeatherDAO> {
        struct WeatherJSON: Codable {
            let weather: [WeatherDAO]
        }
        return OpenWeatherAPI.cityName(cityName: cityName)
            .decodable(type: WeatherJSON.self)
            .map(\.weather.first!)
    }
}