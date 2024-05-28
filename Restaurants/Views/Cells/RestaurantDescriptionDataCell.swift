//
//  RestaurantDescriptionDataCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 28.05.24.
//

import UIKit

class RestaurantDescriptionDataCell: UITableViewCell {
    
    static let cellID = "descriptionTextCell"
    
    private var descriptionLabel: RLabel = {
        let label = RLabel(font: .body)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
}
