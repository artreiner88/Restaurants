//
//  RLabel.swift
//  Restaurants
//
//  Created by Artur Reiner on 13.05.24.
//

import UIKit

class RLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .body)
        numberOfLines = 0
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
}
