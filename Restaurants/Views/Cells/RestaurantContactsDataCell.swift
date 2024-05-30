//
//  RestaurantContactsDataCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 28.05.24.
//

import UIKit

class RestaurantContactsDataCell: UITableViewCell {
    
    static let cellID = "conctactsDataCell"
    
    private var addressLabel: RLabel = {
        let label = RLabel(font: .headline)
        label.text = "ADDRESS"
        return label
    }()
    
    private var fullAddressLabel: RLabel = {
        let label = RLabel(font: .body)
        return label
    }()
    
    private var phoneLabel: RLabel = {
        let label = RLabel(font: .headline)
        label.text = "PHONE"
        return label
    }()
    
    private var phoneNumberLabel: RLabel = {
        let label = RLabel(font: .body)
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addressLabel, fullAddressLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var contactsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneLabel, phoneNumberLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var addressStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationStackView, contactsStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(addressStackView)
        
        NSLayoutConstraint.activate([
            addressStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            addressStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addressStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
    
    func setData(address: String, phone: String) {
        fullAddressLabel.text = address
        phoneNumberLabel.text = phone
    }
}
