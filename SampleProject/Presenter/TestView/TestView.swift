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
        textField.actions(forTarget: self, forControlEvent: .editingDidEnd)
        return textField
    }()

    private (set) lazy var weather: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "날씨: "
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private (set) lazy var weatherDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "설명: "
        label.font = .preferredFont(forTextStyle: .title3)
        return label
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        weather.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
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
