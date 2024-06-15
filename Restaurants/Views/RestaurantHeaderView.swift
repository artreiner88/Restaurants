//
//  RestaurantHeaderView.swift
//  Restaurants
//
//  Created by Artur Reiner on 10.06.24.
//

import UIKit

class RestaurantHeaderView: UIView {
    
    private var restaurantImageView: RImageView = {
        let imageView = RImageView(frame: .zero)
        imageView.layer.cornerRadius = 0
        return imageView
    }()
    
    private var dimView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.2
        return view
    }()
    
    private var restaurantNameLabel = RLabel(font: .title1, color: .white)
    
    private var restaurantTypeLabel: RLabel = {
        let label = RLabel(font: .headline, color: .white)
        label.backgroundColor = .black
        return label
    }()
    
    private var favoriteIconImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerLabelsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [restaurantNameLabel, restaurantTypeLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(restaurantImageView)
        addSubview(headerLabelsStackView)
        addSubview(favoriteIconImageView)
        addSubview(dimView)
        
        NSLayoutConstraint.activate([
            restaurantImageView.topAnchor.constraint(equalTo: topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            restaurantImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerLabelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            favoriteIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            favoriteIconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoriteIconImageView.heightAnchor.constraint(equalToConstant: 30),
            favoriteIconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            dimView.topAnchor.constraint(equalTo: restaurantImageView.topAnchor),
            dimView.leadingAnchor.constraint(equalTo: restaurantImageView.leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: restaurantImageView.trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: restaurantImageView.bottomAnchor),
        ])
    }
    
    func configure(with restaurant: Restaurant) {
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantNameLabel.text = restaurant.name
        restaurantTypeLabel.text = restaurant.type
        
        favoriteIconImageView.tintColor = restaurant.isFavorite ? .systemRed : .white
        favoriteIconImageView.image = restaurant.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
}
