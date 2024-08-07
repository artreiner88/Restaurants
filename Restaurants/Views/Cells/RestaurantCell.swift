//
//  RestaurantCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 10.05.24.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    static let cellID = "restaurantCell"
    
    private let restaurantImageView = RImageView(frame: .zero)
    
    private let restaurantNameLabel: RLabel = {
        let label = RLabel(textStyle: .title2, textColor: .label)
        return label
    }()
    
    private let locationLabel: RLabel = {
        let label = RLabel(textStyle: .body, textColor: .label)
        return label
    }()
    
    private let restaurantTypeLabel: RLabel = {
        let label = RLabel(textStyle: .subheadline, textColor: .systemGray)
        return label
    }()
    
    private let favoriteImageView = RImageView(frame: .zero)
    
    private lazy var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [restaurantNameLabel, locationLabel, restaurantTypeLabel]
            .forEach { stack.addArrangedSubview($0) }
        stack.axis = .vertical
        stack.distribution = .fillProportionally
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
        stack.spacing = 16
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
        contentView.addSubview(stackViewHorizontal)

        let padding = 8.0
        
        NSLayoutConstraint.activate([
            stackViewHorizontal.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewHorizontal.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -(padding * 2)),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(padding * 2)),
            
            restaurantImageView.heightAnchor.constraint(equalToConstant: 120),
            restaurantImageView.widthAnchor.constraint(equalToConstant: 120),
            
            favoriteImageView.heightAnchor.constraint(equalToConstant: 25),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 25),
            
        ])
    }
    
    func set(restaurant: Restaurant) {
        restaurantImageView.image = UIImage(data: restaurant.image)
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
