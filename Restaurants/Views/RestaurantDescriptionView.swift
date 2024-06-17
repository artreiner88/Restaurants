//
//  RestaurantDescriptionView.swift
//  Restaurants
//
//  Created by Artur Reiner on 11.06.24.
//

import UIKit

class RestaurantDescriptionView: UIView {
    
    private var descriptionLabel: RLabel = {
        let label = RLabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setDescription(text: String) {
        descriptionLabel.text = text
    }

}
