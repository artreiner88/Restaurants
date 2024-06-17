//
//  RButton.swift
//  Restaurants
//
//  Created by Artur Reiner on 15.06.24.
//

import UIKit

class RButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    private func configure(style: UIButton.Configuration, textStyle: UIFont.TextStyle, color: UIColor) {
        var configuration = style
        configuration.baseBackgroundColor = color
        configuration.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: textStyle)
            return outgoing
        }
        self.configuration = configuration
    }
}
