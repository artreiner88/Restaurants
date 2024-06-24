//
//  NewRestaurantTextViewCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 24.06.24.
//

import UIKit

class NewRestaurantTextViewCell: UITableViewCell {
    
    static let cellID = "texViewCell"
    
    private let textViewLabel: RLabel = {
        let label = RLabel()
        label.text = "Desciption"
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        textView.textColor = .label
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.backgroundColor = .tertiarySystemBackground
        textView.keyboardType = .default
        textView.returnKeyType = .next
        textView.autocorrectionType = .no
        return textView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textViewLabel, textView])
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
            
            textView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
