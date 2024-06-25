//
//  NewRestaurantTextFieldCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 24.06.24.
//

import UIKit

class NewRestaurantTextFieldCell: UITableViewCell, UITextFieldDelegate {
    
    static let cellID = "textFieldCell"
    
    private let textFieldLabel: RLabel = {
        let label = RLabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with labelText: String, and textFieldPlaceholder: String) {
        textFieldLabel.text = labelText
        textField.placeholder = textFieldPlaceholder
    }
}
