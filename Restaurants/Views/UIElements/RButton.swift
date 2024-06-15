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
    
    convenience init(style: UIButton.Configuration, textStyle: UIFont.TextStyle, color: UIColor) {
        self.init(frame: .zero)
        configure(style: style, textStyle: textStyle, color: color)
    }
    
    private func configure(style: UIButton.Configuration, textStyle: UIFont.TextStyle, color: UIColor) {
        translatesAutoresizingMaskIntoConstraints = false
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
