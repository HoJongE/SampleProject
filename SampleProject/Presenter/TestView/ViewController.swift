//
//  ViewController.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import UIKit
import RxCocoa
import RxSwift

final class ViewController: UIViewController {

    private lazy var testView: TestView = TestView()
    private let viewModel: TestViewModel = TestViewModel(weatherService: OpenWeatherService.shared)
    private let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setObserver()
    }

    override func loadView() {
        self.view = testView
    }

}

private extension ViewController {
    func setObserver() {

        testView.textField.rx
            .controlEvent(.editingDidEnd)
            .compactMap { [weak self] in
                self?.testView.textField.text}
            .subscribe(onNext: { [weak self] string in
                self?.viewModel.requestWeather(string)
            })
            .disposed(by: disposeBag)

        let weather = viewModel.weathers
            .asDriver(onErrorJustReturn: WeatherDAO(id: 0, main: "", description: ""))

        weather
            .map {
                "날씨: " + $0.main
            }
            .drive(testView.weather.rx.text)
            .disposed(by: disposeBag)

        weather
            .map {
                "설명: " + $0.description
            }
            .drive(testView.weatherDescription.rx.text)
            .disposed(by: disposeBag)

            
    }
}

#if DEBUG
import SwiftUI
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview()
    }
}
#endif
