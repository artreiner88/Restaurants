//
//  RestaurantDetailViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 26.05.24.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    
    private var restaurantImageView: RImageView = {
        let image = RImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
//    private var headerView: UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = .red
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: self.bounds)
//        tableView.tableHeaderView = headerView
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
    
    private var restaurantNameLabel: RLabel = {
        let label = RLabel(font: .title1, color: .white)
        return label
    }()
    
    private var restaurantTypeLabel: RLabel = {
        let label = RLabel(font: .headline, color: .black)
        return label
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
    
    private var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(restaurantImageView)
        addSubview(headerLabelsStackView)
        addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
//            headerView.heightAnchor.constraint(equalToConstant: 445),
//            headerView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            
            restaurantImageView.topAnchor.constraint(equalTo: topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            restaurantImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            headerLabelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
//            restaurantTypeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//            restaurantTypeLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16),
//            restaurantTypeLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//            restaurantNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//            restaurantNameLabel.bottomAnchor.constraint(equalTo: restaurantTypeLabel.topAnchor, constant: -16),
//            restaurantNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(with restaurant: Restaurant) {
        restaurantNameLabel.text = restaurant.name
        restaurantTypeLabel.text = restaurant.type
        restaurantImageView.image = UIImage(named: restaurant.image)
    }
}
