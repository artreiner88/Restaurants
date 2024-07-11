//
//  RestaurantContactsView.swift
//  Restaurants
//
//  Created by Artur Reiner on 11.06.24.
//

import UIKit

class RestaurantContactsView: UIView {
    
    private var addressLabel: RLabel = {
        let label = RLabel(textStyle: .headline, textColor: .label)
        label.text = "ADDRESS"
        return label
    }()
    
    private var phoneLabel: RLabel = {
        let label = RLabel(textStyle: .headline, textColor: .label)
        label.text = "PHONE"
        return label
    }()
    
    private let fullAddressLabel: RLabel = {
        let label = RLabel(textStyle: .body, textColor: .label)
        return label
    }()
    
    private let phoneNumberLabel: RLabel = {
        let label = RLabel(textStyle: .body, textColor: .label)
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressLabel, fullAddressLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var phoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneLabel, phoneNumberLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var contactsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationStackView, phoneStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(contactsStackView)
        
        NSLayoutConstraint.activate([
            contactsStackView.topAnchor.constraint(equalTo: topAnchor),
            contactsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contactsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contactsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setData(location: String, phone: String) {
        fullAddressLabel.text = location
        phoneNumberLabel.text = phone
    }
}
