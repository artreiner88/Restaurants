//
//  RestaurantCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 10.05.24.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    static let cellID = "restaurantCell"
    
    private let restaurantImageView = RImageView(width: 130, height: 130)
    private let restaurantNameLabel = RLabel(font: .title2)
    private let locationLabel = RLabel(font: .body)
    private let restaurantTypeLabel = RLabel(font: .subheadline, color: .systemGray)
    private let favoriteImageView = RImageView(width: 25, height: 25)
    
    private lazy var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [restaurantNameLabel, locationLabel, restaurantTypeLabel]
            .forEach { stack.addArrangedSubview($0) }
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
       let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        [restaurantImageView, stackViewVertical, favoriteImageView]
            .forEach { stack.addArrangedSubview($0) }
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .top
        stack.spacing = 20
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        tintColor = .systemRed
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(stackViewHorizontal)
        NSLayoutConstraint.activate([
            stackViewHorizontal.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func set(restaurant: Restaurant) {
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantNameLabel.text = restaurant.name
        locationLabel.text = restaurant.location
        restaurantTypeLabel.text = restaurant.type
        favoriteImageView.isHidden = restaurant.isFavorite ? false : true
        favoriteImageView.image = UIImage(systemName: "heart.fill")
    }
    
    func favorite() {
        favoriteImageView.isHidden.toggle()
    }
}
