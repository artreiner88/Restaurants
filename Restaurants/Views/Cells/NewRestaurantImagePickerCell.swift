//
//  NewRestaurantImagePickerCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 24.06.24.
//

import UIKit

class NewRestaurantImagePickerCell: UITableViewCell {
    
    static let cellID = "imagePickerCell"
    
    private let restaurantImageView: RImageView = {
        let imageView = RImageView(frame: .zero)
        imageView.image = UIImage(named: "newphoto")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(restaurantImageView)
        
        NSLayoutConstraint.activate([
            restaurantImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            restaurantImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            restaurantImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            restaurantImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
