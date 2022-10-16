//
//  WeatherDAO.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import Foundation

// Entity 를 나타냄 - 서버와의 통신 객체 또는 DB 와 통신하는 객체
struct WeatherDAO: Codable {
    let id: Int
    let main: String
    let description: String
}

