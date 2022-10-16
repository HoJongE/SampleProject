//
//  RequestWeatherUsecase.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/06.
//

import RxSwift
import Foundation

// Usecase 를 사용하는 ViewModel 의 테스트가 수월해질 수 있도록, Usecase 모델을 Protocol화 한다!
// ViewModel 은 프로토콜, 즉 추상화에 의존하기 때문에 추상화를 구현하는 가짜 (Mock, Spy 등의 Test Double) 객체를 주입해도 정상적으로 동작함

protocol RequestWeatherUsecase {
    func requestWeather(of cityName: String) -> Observable<WeatherDAO>
}

// Usecase 는 로직 실행에 필요한 Service (API), 혹은 Repository (Data) Layer 를 사용해야 한다.
// 그러나 Service 와 Repository 는 생각보다 변경이 자주 일어날 수 있는 부분임
// 예를 들어 날씨를 제공하는 API 의 요금제가 마음에 들지 않아 다른 API 를 사용해야 하거나 (애플 날씨 API -> 다른 공짜 API)
// Firebase DB 를 사용하다가 자체적인 DB 를 구축해야 하는 경우
// Usecase 가 DB 와 API 에 의존적인 객체를 사용할 경우, DB 혹은 API 변경 시 Usecase 도 변경될 가능성이 매우매우 큼
// Usecase 는 고수준의 Layer 이기 때문에, 저수준인 Service Layer 혹은 Data Layer 에 의해서 변경이 일어나면 안됨 (그러나 알긴 알아야 한다)
// 따라서 이런 문제를 의존성 역전 (DIP) 를 통해 해결한다.
// 저수준인 Repository 와 고수준인 Usecase 가 모두 추상화에 의존함으로써, 의존성이 올바르지 못한 방향으로 흐르는 것을 방지함
struct RealRequestWeatherUsecase: RequestWeatherUsecase {
    private let weatherService: WeatherService

    init(weatherService: WeatherService = OpenWeatherService.shared) {
        self.weatherService = weatherService
    }

    func requestWeather(of cityName: String) -> Observable<WeatherDAO> {
        return weatherService.weatherOfCity(cityName)
    }
}
