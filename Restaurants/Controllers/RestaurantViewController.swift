//
//  RestaurantViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 10.06.24.
//

import UIKit

class RestaurantViewController: UIViewController {

    var restaurant: Restaurant!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var restaurantHeaderView: RestaurantHeaderView = {
        let view = RestaurantHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(with: restaurant)
        return view
    }()
    
    private lazy var restaurantDescriptionView: RestaurantDescriptionView = {
        let view = RestaurantDescriptionView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setDescription(text: restaurant.description)
        return view
    }()
    
    private lazy var restaurantContactsView: RestaurantContactsView = {
        let view = RestaurantContactsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setData(location: restaurant.location, phone: restaurant.phone)
        return view
    }()
    
    private lazy var restaurantMapView: RestaurantMapView = {
        let view = RestaurantMapView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restaurantMapViewTapped)))
        view.configure(with: restaurant.location)
        return view
    }()
    
    private let rateRestaurantButton: RButton = {
        let button = RButton(style: .filled(), textStyle: .headline, color: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0))
        button.setTitle("Rate it", for: .normal)
        button.addTarget(RestaurantViewController.self, action: #selector(rateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    @objc private func restaurantMapViewTapped() {
        let mapVC = MapViewController()
        mapVC.restaurant = restaurant
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc private func rateButtonTapped() {
        let reviewVC = ReviewViewController()
        present(reviewVC, animated: true)
    }
    
    private func configureNavBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.hidesBarsOnSwipe = false
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [restaurantHeaderView, restaurantDescriptionView, restaurantContactsView, restaurantMapView, rateRestaurantButton].forEach(contentView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            restaurantHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            restaurantHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            restaurantHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            restaurantHeaderView.heightAnchor.constraint(equalToConstant: 400),
            
            restaurantDescriptionView.topAnchor.constraint(equalTo: restaurantHeaderView.bottomAnchor, constant: 16),
            restaurantDescriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            restaurantDescriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            restaurantContactsView.topAnchor.constraint(equalTo: restaurantDescriptionView.bottomAnchor, constant: 16),
            restaurantContactsView.leadingAnchor.constraint(equalTo: restaurantDescriptionView.leadingAnchor),
            restaurantContactsView.trailingAnchor.constraint(equalTo: restaurantDescriptionView.trailingAnchor),
            
            restaurantMapView.topAnchor.constraint(equalTo: restaurantContactsView.bottomAnchor, constant: 16),
            restaurantMapView.leadingAnchor.constraint(equalTo: restaurantContactsView.leadingAnchor),
            restaurantMapView.trailingAnchor.constraint(equalTo: restaurantContactsView.trailingAnchor),
            restaurantMapView.heightAnchor.constraint(equalToConstant: 200),
            
            rateRestaurantButton.topAnchor.constraint(equalTo: restaurantMapView.bottomAnchor, constant: 16),
            rateRestaurantButton.leadingAnchor.constraint(equalTo: restaurantMapView.leadingAnchor),
            rateRestaurantButton.trailingAnchor.constraint(equalTo: restaurantMapView.trailingAnchor),
            rateRestaurantButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            rateRestaurantButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
