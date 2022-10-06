//
//  SampleProjectTests.swift
//  SampleProjectTests
//
//  Created by JongHo Park on 2022/10/05.
//

import XCTest
import RxBlocking
import RxTest
@testable import SampleProject

final class OpenWeatherServiceTest: XCTestCase {

    private var openWeahterService: WeatherService!

    // 단위 테스트 시작 전 실행되는 함수!
    // 단위 테스트는 다른 단위 테스트들에 독립적이어야 하므로, 여기서 테스트에 사용할 각 데이터의 상태를 초기화해주어야함
    override func setUpWithError() throws {
        try super.setUpWithError()
        openWeahterService = OpenWeatherService()
    }

    // 단위 테스트 실행 후 실행되는 함수
    // 위에서 설명한 것 같이 여기서 테스트에 사용한 각 데이터의 상태를 초기화해주어야함 (이를테면 테스트에서 저장한 DB 데이터를 삭제한다든지)
    override func tearDownWithError() throws {
        openWeahterService = nil
        try super.tearDownWithError()
    }


    // 이것들이 하나의 단위 테스트가 된다!
    func testExample() throws {
        // 테스트 성공!
        XCTAssertTrue(true)
    }

    // Daegu 의 날씨를 잘 받아오는지 확인해보는 테스트, Test 의 이름은 항상 test 로 시작해야함 (그래야 인식함)
    func testDaeguWeatherDataReturnSuccessfully() throws {
        // 이 테스트 데이터가 주어졌을 때
        let cityName: String = "Daegu"
        // 이러한 로직을 실행하면
        let result = try? openWeahterService.weatherOfCity(cityName)
            .toBlocking(timeout: 5).first()
        // 결과값은 다음과 같다.
        XCTAssertNotNil(result)
        print(result)
    }

}
