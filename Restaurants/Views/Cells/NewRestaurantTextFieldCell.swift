//
//  NewRestaurantFormFieldCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 24.06.24.
//

import UIKit

class NewRestaurantTextFieldCell: UITableViewCell, UITextFieldDelegate {
    
    static let cellID = "formField"
    
    private let textFieldLabel: RLabel = {
        let label = RLabel()
        label.text = "Name"
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "type me in"
        textField.borderStyle = .roundedRect
        textField.textColor = .label
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        textField.backgroundColor = .tertiarySystemBackground
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldLabel, textField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            textField.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
