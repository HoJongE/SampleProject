//
//  TestViewModel.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import RxSwift
import RxCocoa
import Foundation

// Entity 로는 View 에 보여줄 수 없음 -> 적절한 변환 과정이 필요함
// 예를 들어 Entity 는 날씨에 대한 정보를 보통 정수형으로 저장할 가능성이 있음 (enum 과 같은 custom Type 은 DB 에 넣을 수 없으므로)
// 따라서 View 에 보여줄 Model 이 따로 필요함
struct WeatherVM {

    let weatherName: String
    let weatherDescription: String

    // Entity 를 ViewModel 로 변환
    init(from weather: WeatherDAO) {
        self.weatherName = "날씨: " + weather.main
        self.weatherDescription = "설명: " + weather.description
    }
}

final class TestViewModel {

    // Business Logic (Usecase) 를 주입받음 (이니셜라이저를 통해)
    private let requestWeatherUsecase: RequestWeatherUsecase

    // Weather 데이터 stream
    let weathers: PublishRelay<WeatherVM> = .init()
    private let disposeBag: DisposeBag = .init()

    init(requestWeatherUsecase: RequestWeatherUsecase) {
        self.requestWeatherUsecase = requestWeatherUsecase
    }

    // View 에서 날씨를 요청할 버튼등을 클릭해서 이벤트를 발생시키면 실행될 함수
    func requestWeather(_ cityName: String) {
        requestWeatherUsecase.requestWeather(of: cityName)
            .map { WeatherVM(from: $0) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.weathers.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
