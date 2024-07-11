//
//  NewRestaurantImagePickerView.swift
//  Restaurants
//
//  Created by Artur Reiner on 26.06.24.
//

import UIKit

class NewRestaurantImageView: UIImageView {
    
    private let restaurantImageView: RImageView = {
        let imageView = RImageView(frame: .zero)
        imageView.image = UIImage(named: "newphoto")
        imageView.backgroundColor = .systemGray6
        return imageView
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
        
        NSLayoutConstraint.activate([
            restaurantImageView.topAnchor.constraint(equalTo: topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            restaurantImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            restaurantImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configure(with image: UIImage) {
        restaurantImageView.image = image
    }
}
