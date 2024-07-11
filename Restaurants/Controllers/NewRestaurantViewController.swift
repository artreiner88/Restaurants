//
//  NewRestaurantViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 26.06.24.
//

import UIKit
import CoreData

class NewRestaurantViewController: UIViewController {
    
    var restaurant: Restaurant!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 16
        return view
    }()
    
//    private lazy var restaurantImageView: NewRestaurantImageView = {
//        let imagePicker = NewRestaurantImageView(frame: .zero)
//        imagePicker.isUserInteractionEnabled = true
//        imagePicker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
//        return imagePicker
//    }()
    
    private lazy var restaurantImageView: RImageView = {
        let imageView = RImageView(frame: .zero)
        imageView.image = UIImage(named: "newphoto")
        imageView.backgroundColor = .systemGray6
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectImage)))
        return imageView
    }()
    
    private let nameLabel: RLabel = {
        let label = RLabel(textStyle: .headline, textColor: .darkGray)
        label.text = "NAME"
        return label
    }()
    private let nameTextField = RTextField(placeholder: "Fill in the resaturant name")
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let typeLabel: RLabel = {
        let label = RLabel(textStyle: .headline, textColor: .darkGray)
        label.text = "TYPE"
        return label
    }()
    private let typeTextField = RTextField(placeholder: "Fill in the resaturant type")
    
    private lazy var typeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [typeLabel, typeTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let addressLabel: RLabel = {
        let label = RLabel(textStyle: .headline, textColor: .darkGray)
        label.text = "ADDRESS"
        return label
    }()
    private let addressTextField = RTextField(placeholder: "Fill in the resaturant address")
    
    private lazy var addressStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressLabel, addressTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let phoneLabel: RLabel = {
        let label = RLabel(textStyle: .headline, textColor: .darkGray)
        label.text = "PHONE"
        return label
    }()
    private let phoneTextField = RTextField(placeholder: "Fill in the resaturant phone")
    
    private lazy var phoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [phoneLabel, phoneTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let descriptionLabel: RLabel = {
        let label = RLabel(textStyle: .headline, textColor: .darkGray)
        label.text = "DESCRIPTION"
        return label
    }()
    private let descriptionTextView = RTextView()
    
    private lazy var descriptionTextViewPlaceholder: RLabel = {
        let label = RLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fill in the restaurant description"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray3
        label.sizeToFit()
        label.isHidden = !descriptionTextView.text.isEmpty
        return label
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, descriptionTextView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        setupLayout()
        setupDelegates()
        hideKeyboard()
    }
    
    private func configureNavBar() {
        title = "New Restaurant"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        rightBarButton.tintColor = UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeViewController))
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
        
        guard let appearance = navigationController?.navigationBar.standardAppearance else { return }
        appearance.configureWithTransparentBackground()
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupDelegates() {
        nameTextField.delegate = self
        typeTextField.delegate = self
        addressTextField.delegate = self
        phoneTextField.delegate = self
        
        descriptionTextView.delegate = self
    }
    
    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func saveButtonTapped() {
        if didFormFilled() {
            saveRestaurant()
            closeViewController()
        } else {
            let alertController = UIAlertController(title: "Oops", message: "You should fill in all the fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    }
    
    private func saveRestaurant() {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            restaurant = Restaurant(context: appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text!
            restaurant.type = typeTextField.text!
            restaurant.location = addressTextField.text!
            restaurant.phone = phoneTextField.text!
            restaurant.summary = descriptionTextView.text!
            restaurant.isFavorite = false
            
            if let imageData = restaurantImageView.image?.pngData() {
                restaurant.image = imageData
            }
            
            print("Saving data to context")
            appDelegate.saveContext()
        }
    }
    
    private func didFormFilled() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else { return false }
        guard let type = typeTextField.text, !type.isEmpty else { return false }
        guard let address = addressTextField.text, !address.isEmpty else { return false }
        guard let phone = phoneTextField.text, !phone.isEmpty else { return false }
        guard let description = descriptionTextView.text, !description.isEmpty else { return false}
        return true
    }
    
    @objc private func closeViewController() {
        dismiss(animated: true)
    }
    
    @objc private func selectImage() {
        let photoSourceRequester = UIAlertController(title: "", message: "Choose Your Photo Source", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        photoSourceRequester.addAction(cameraAction)
        photoSourceRequester.addAction(photoLibraryAction)
        photoSourceRequester.addAction(cancelAction)
        
        present(photoSourceRequester, animated: true)
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        descriptionTextView.addSubview(descriptionTextViewPlaceholder)
        
        [restaurantImageView, nameStackView, typeStackView, addressStackView, phoneStackView, descriptionStackView]
            .forEach(contentView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            restaurantImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            restaurantImageView.heightAnchor.constraint(equalToConstant: 200),

            descriptionTextView.heightAnchor.constraint(equalToConstant: 200),
            descriptionTextViewPlaceholder.topAnchor.constraint(equalTo: descriptionTextView.topAnchor, constant: 8),
            descriptionTextViewPlaceholder.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 8),
            descriptionTextViewPlaceholder.trailingAnchor.constraint(equalTo: descriptionTextView.trailingAnchor),
            descriptionTextViewPlaceholder.bottomAnchor.constraint(equalTo: descriptionTextView.bottomAnchor),
        ])
    }
}


extension NewRestaurantViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            typeTextField.becomeFirstResponder()
        case typeTextField:
            addressTextField.becomeFirstResponder()
        case addressTextField:
            phoneTextField.becomeFirstResponder()
        case phoneTextField:
            descriptionTextView.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}


extension NewRestaurantViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        descriptionTextViewPlaceholder.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionTextViewPlaceholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        descriptionTextViewPlaceholder.isHidden = !textView.text.isEmpty
    }
}


extension NewRestaurantViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
//        restaurantImageView.configure(with: selectedImage)
        restaurantImageView.image = selectedImage
        closeViewController()
    }
}
