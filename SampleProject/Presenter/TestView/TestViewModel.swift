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

    private let requestWeatherUsecase: RequestWeatherUsecase

    let weathers: PublishRelay<WeatherDAO> = .init()
    private let disposeBag: DisposeBag = .init()

    init(requestWeatherUsecase: RequestWeatherUsecase) {
        self.requestWeatherUsecase = requestWeatherUsecase
    }

    func requestWeather(_ cityName: String) {
        requestWeatherUsecase.requestWeather(of: cityName)
            .subscribe(onNext: { weather in
                self.weathers.accept(weather)
            })
            .disposed(by: disposeBag)
    }
}
