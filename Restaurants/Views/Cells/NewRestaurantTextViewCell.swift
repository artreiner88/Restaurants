//
//  NewRestaurantTextViewCell.swift
//  Restaurants
//
//  Created by Artur Reiner on 24.06.24.
//

import UIKit

class NewRestaurantTextViewCell: UITableViewCell {
    
    static let cellID = "textViewCell"
    
    private let textViewLabel: RLabel = {
        let label = RLabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .darkGray
        label.text = "DESCRIPTION"
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
        textView.delegate = self
        return textView
    }()
    
    private lazy var textViewPlaceholder: RLabel = {
        let label = RLabel()
        label.text = "Fill in the restaurant description"
        label.textColor = .systemGray3
        label.sizeToFit()
        label.isHidden = !textView.text.isEmpty
        return label
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
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(stackView)
        textView.addSubview(textViewPlaceholder)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            textViewPlaceholder.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            textViewPlaceholder.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 8)
        ])
    }
}

extension NewRestaurantTextViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholder.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPlaceholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewPlaceholder.isHidden = !textView.text.isEmpty
    }
}
