//
//  RestaurantCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 10.05.24.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    static let cellID = "cell"
    
    let restaurantImageView = RImageView(width: 120, height: 120)
    let restaurantNameLabel = RLabel(font: .title2)
    let locationLabel = RLabel(font: .body)
    let restaurantTypeLabel = RLabel(font: .subheadline, color: .systemGray)
    let favoriteImageView = RImageView(frame: .zero)
    
    lazy var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [restaurantNameLabel, locationLabel, restaurantTypeLabel]
            .forEach { stack.addArrangedSubview($0) }
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    lazy var favoriteStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.addArrangedSubview(favoriteImageView)
        return stack
    }()
    
    lazy var stackViewHorizontal: UIStackView = {
       let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        [restaurantImageView, stackViewVertical, favoriteStack]
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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(stackViewHorizontal)
        NSLayoutConstraint.activate([
            stackViewHorizontal.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackViewHorizontal.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackViewHorizontal.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
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
