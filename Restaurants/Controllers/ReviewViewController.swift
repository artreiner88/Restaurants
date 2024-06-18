//
//  ReviewViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 16.06.24.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var restaurant: Restaurant!
    private lazy var rateRestaurantButtons = [awesomeButton, goodButton, okayButton, badButton, terribleButton]
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: restaurant.image))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.frame = self.view.bounds
        return view
    }()
    
    private lazy var closeButton: RButton = {
        let button = RButton(backgroundColor: .white, title: "")
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold)), for: .normal)
        button.tintColor = UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        return button
    }()
    
    private let awesomeButton: RButton = {
        let button = RButton()
        button.setTitle("Awesome", for: .normal)
        button.setImage(UIImage(named: "love"), for: .normal)
        return button
    }()
    
    private let goodButton: RButton = {
        let button = RButton()
        button.setTitle("Good", for: .normal)
        button.setImage(UIImage(named: "cool"), for: .normal)
        return button
    }()
    
    private let okayButton: RButton = {
        let button = RButton()
        button.setTitle("Okay", for: .normal)
        button.setImage(UIImage(named: "happy"), for: .normal)
        return button
    }()
    
    private let badButton: RButton = {
        let button = RButton()
        button.setTitle("Bad", for: .normal)
        button.setImage(UIImage(named: "sad"), for: .normal)
        return button
    }()
    
    private let terribleButton: RButton = {
        let button = RButton()
        button.setTitle("Terrible", for: .normal)
        button.setImage(UIImage(named: "angry"), for: .normal)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: rateRestaurantButtons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        hideUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateUIElements()
    }
    
    private func configureNavBar() {
        let image = UIImage(systemName: "xmark")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(closeViewController))
        button.tintColor = UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func closeViewController() {
        dismiss(animated: true)
    }
    
    private func hideUIElements() {
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        let moveUpTransform = CGAffineTransform.init(translationX: 0, y: -600)
        
        // Make the button invisible and move off the screen
        rateRestaurantButtons.forEach {
            $0.transform = moveScaleTransform
            $0.alpha = 0
        }
        
        closeButton.transform = moveUpTransform
    }
    
    private func animateUIElements() {
        var delay = 0.1
        
        // Animate rate buttons
        rateRestaurantButtons.forEach { button in
            UIView.animate(withDuration: 0.4, delay: delay) {
                button.alpha = 1.0
                button.transform = .identity
            }
            delay += 0.05
        }
        
        // Animate the close button
        UIView.animate(withDuration: 0.4, delay: 0.1) {
            self.closeButton.transform = .identity
        }
    }
    
    private func setupLayout() {
        view.addSubview(contentView)
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(blurEffectView)
        contentView.addSubview(closeButton)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
