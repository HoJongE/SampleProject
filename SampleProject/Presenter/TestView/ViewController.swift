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

    // ViewController 는 View 와 ViewModel 에 대한 의존성을 가짐
    private lazy var testView: TestView = TestView()
    private let viewModel: TestViewModel = TestViewModel(requestWeatherUsecase: RealRequestWeatherUsecase())
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

    // ViewModel 의 data 들에 대한 binding 을 설정
    func setObserver() {

        testView.button
            .rx
            .tap
            .compactMap { [weak self] in
                self?.testView.textField.text
            }
            .subscribe(onNext: { [weak self] cityName in
                self?.viewModel.requestWeather(cityName)
            })
            .disposed(by: disposeBag)

        // 뷰모델 날씨 데이터의 날씨 이름을 관련 textField 에 연결
        viewModel.weathers
            .map(\.weatherName)
            .bind(to: testView.weather.rx.text)
            .disposed(by: disposeBag)

        // 뷰모델 날씨 데이터의 날씨 설명을 관련 textField 에 연결
        viewModel.weathers
            .map(\.weatherDescription)
            .bind(to: testView.weatherDescription.rx.text)
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
