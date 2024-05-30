//
//  RestaurantDescriptionDataCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 28.05.24.
//

import UIKit

class RestaurantDescriptionDataCell: UITableViewCell {
    
    static let cellID = "descriptionDataCell"
    
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
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func setDescription(text: String) {
        descriptionLabel.text = text
    }
}
