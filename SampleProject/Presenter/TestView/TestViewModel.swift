//
//  TestViewModel.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import RxSwift
import RxRelay
import Foundation

final class TestViewModel {

    private let weatherService: WeatherService
    let weathers: PublishRelay<WeatherDAO> = .init()
    private let disposeBag: DisposeBag = .init()

    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }

    func requestWeather(_ cityName: String) {
        weatherService.weatherOfCity(cityName)
            .subscribe(onNext: { weather in
                self.weathers.accept(weather)
            })
            .disposed(by: disposeBag)
    }
}
