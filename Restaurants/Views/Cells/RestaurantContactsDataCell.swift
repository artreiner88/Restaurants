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
        label.text = label.text?.uppercased()
        return label
    }()
    
    private var fullAddressLabel: RLabel = {
        let label = RLabel(font: .body)
        return label
    }()
    
    private var phoneLabel: RLabel = {
        let label = RLabel(font: .headline)
        label.text = label.text?.uppercased()
        return label
    }()
    
    private var phoneNumberLabel: RLabel = {
        let label = RLabel(font: .body)
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addressLabel, fullAddressLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var contactsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneLabel, phoneNumberLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var addressStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationStackView, contactsStackView])
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
            addressStackView.topAnchor.constraint(equalTo: topAnchor),
            addressStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addressStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addressStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
