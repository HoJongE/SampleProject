//
//  TestView.swift
//  SampleProject
//
//  Created by JongHo Park on 2022/10/05.
//

import UIKit

class TestView: UIView {

    private (set) lazy var textField: UITextField = {
        var textField: UITextField = UITextField(frame: .zero)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.returnKeyType = .done
        return textField
    }()

    private (set) lazy var weather: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private (set) lazy var weatherDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private (set) lazy var button: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "날씨 요청"
        let button = UIButton(configuration: configuration)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("Don`t need to implement")
    }
}

private extension TestView {
    func setUpViews() {
        setUpAutoLayout()
    }

    func setUpAutoLayout() {
        addSubview(weather)
        addSubview(weatherDescription)
        addSubview(textField)
        addSubview(button)

        textField.translatesAutoresizingMaskIntoConstraints = false
        weather.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            weather.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 48),
            weather.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            weatherDescription.topAnchor.constraint(equalTo: weather.bottomAnchor, constant: 16),
            weatherDescription.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -32)
        ])
    }
}

#if DEBUG
import SwiftUI
struct TestViewPreview: PreviewProvider {
    static var previews: some View {
        TestView().toPreview()
    }
}
#endif
