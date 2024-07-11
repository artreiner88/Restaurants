//
//  RTextField.swift
//  Restaurants
//
//  Created by Artur Reiner on 27.06.24.
//

import UIKit

class RTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        borderStyle = .roundedRect
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        backgroundColor = .tertiarySystemBackground
        keyboardType = .default
        returnKeyType = .next
        clearButtonMode = .whileEditing
        autocorrectionType = .no
    }
}
