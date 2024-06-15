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
    
    convenience init(font: UIFont.TextStyle, color: UIColor = .label) {
        self.init(frame: .zero)
        configure(font: font, color: color)
    }
    
    private func configure(font: UIFont.TextStyle, color: UIColor = .label) {
        translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.preferredFont(forTextStyle: font)
        textColor = color
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.5
        numberOfLines = 0
    }
}
