//
//  RequestWeatherUsecase.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/06.
//

import RxSwift
import Foundation

protocol RequestWeatherUsecase {
    func requestWeather(of cityName: String) -> Observable<WeatherDAO>
}

struct RealRequestWeatherUsecase: RequestWeatherUsecase {
    private let weatherService: WeatherService

    init(weatherService: WeatherService = OpenWeatherService.shared) {
        self.weatherService = weatherService
    }

    func requestWeather(of cityName: String) -> Observable<WeatherDAO> {
        return weatherService.weatherOfCity(cityName)
    }
}
