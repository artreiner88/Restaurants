//
//  RImageView.swift
//  Restaurants
//
//  Created by Artur Reiner on 13.05.24.
//

import UIKit

class RImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(width: CGFloat, height: CGFloat) {
        self.init(frame: .zero)
        configure(with: width, and: height)
    }
    
    func configure(with width: CGFloat, and height: CGFloat) {
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height),
            widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
}
