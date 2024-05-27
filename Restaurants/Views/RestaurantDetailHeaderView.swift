//
//  RestaurantDetailHeaderView.swift
//  Restaurants
//
//  Created by Artur Reiner on 26.05.24.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    
    private var restaurantImageView: RImageView = {
        let imageView = RImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var dimView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.2
        return view
    }()
    
    private var restaurantNameLabel: RLabel = {
        let label = RLabel(font: .title1, color: .white)
        return label
    }()
    
    private var restaurantTypeLabel: RLabel = {
        let label = RLabel(font: .headline, color: .white)
        label.backgroundColor = .black
        return label
    }()
    
    private var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(favoriteButton)
        addSubview(dimView)
        
        NSLayoutConstraint.activate([
            
            restaurantImageView.topAnchor.constraint(equalTo: topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            restaurantImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerLabelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
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
        
        favoriteButton.tintColor = restaurant.isFavorite ? .systemRed : .white
        let heartImage = restaurant.isFavorite ? "heart.fill" : "heart"
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        favoriteButton.setImage(UIImage(systemName: heartImage, withConfiguration: configuration), for: .normal)
    }
}
