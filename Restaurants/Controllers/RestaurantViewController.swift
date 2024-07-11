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
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var restaurantHeaderView: RestaurantHeaderView = {
        let view = RestaurantHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(with: restaurant)
        return view
    }()
    
    private lazy var restaurantDescriptionLabel: RLabel = {
        let label = RLabel(textStyle: .body, textColor: .label)
        label.text = restaurant.summary
        return label
    }()
    
    private lazy var restaurantContactsView: RestaurantContactsView = {
        let view = RestaurantContactsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setData(location: restaurant.location, phone: restaurant.phone)
        return view
    }()
    
    private lazy var restaurantMapView: RestaurantMapView = {
        let view = RestaurantMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(restaurantMapViewTapped)))
        view.configure(with: restaurant.location)
        return view
    }()
    
    private lazy var rateRestaurantButton: RButton = {
        let button = RButton(backgroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0), title: "Rate it")
        button.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
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
        reviewVC.delegate = self
        
        if let image = UIImage(data: restaurant.image) {
            reviewVC.setBackgroundImage(image: image)
        }
        present(reviewVC, animated: true)
    }
    
    private func configureNavBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.hidesBarsOnSwipe = false
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [restaurantHeaderView, restaurantDescriptionLabel, restaurantContactsView, restaurantMapView, rateRestaurantButton].forEach(contentView.addSubview(_:))
        
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
            
            restaurantDescriptionLabel.topAnchor.constraint(equalTo: restaurantHeaderView.bottomAnchor, constant: 16),
            restaurantDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            restaurantDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            restaurantContactsView.topAnchor.constraint(equalTo: restaurantDescriptionLabel.bottomAnchor, constant: 16),
            restaurantContactsView.leadingAnchor.constraint(equalTo: restaurantDescriptionLabel.leadingAnchor),
            restaurantContactsView.trailingAnchor.constraint(equalTo: restaurantDescriptionLabel.trailingAnchor),
            
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

extension RestaurantViewController: ReviewViewControllerDelegate {
    func didSelectRating(rating: Restaurant.Rating) {
        restaurantHeaderView.setRatingImage(rating: rating)
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            restaurant.rating = rating
            appDelegate.saveContext()
        }
    }
}
