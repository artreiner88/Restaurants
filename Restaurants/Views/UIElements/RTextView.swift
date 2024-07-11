//
//  RTextView.swift
//  Restaurants
//
//  Created by Artur Reiner on 27.06.24.
//

import UIKit

class RTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 8.0
        textColor = .label
        font = UIFont.preferredFont(forTextStyle: .body)
        backgroundColor = .tertiarySystemBackground
        keyboardType = .default
        returnKeyType = .next
        autocorrectionType = .no
        isEditable = true
    }
}
