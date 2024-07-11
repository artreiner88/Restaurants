//
//  EmptyRestaurantsView.swift
//  Restaurants
//
//  Created by Artur Reiner on 01.07.24.
//

import UIKit

class EmptyRestaurantsView: UIView {
    
    private let image: RImageView = {
        return RImageView(frame: .zero)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
}
