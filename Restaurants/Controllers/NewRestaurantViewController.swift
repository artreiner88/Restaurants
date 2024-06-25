//
//  NewRestaurantViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 23.06.24.
//

import UIKit

class NewRestaurantViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewRestaurantImagePickerCell.self, forCellReuseIdentifier: NewRestaurantImagePickerCell.cellID)
        tableView.register(NewRestaurantTextFieldCell.self, forCellReuseIdentifier: NewRestaurantTextFieldCell.cellID)
        tableView.register(NewRestaurantTextViewCell.self, forCellReuseIdentifier: NewRestaurantTextViewCell.cellID)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setupLayout()
    }
    
    private func configureNavBar() {
        title = "New Restaurant"
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeViewController))
        rightBarButton.tintColor = UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc private func saveButtonTapped() {
        closeViewController()
    }
    
    @objc private func closeViewController() {
        dismiss(animated: true)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension NewRestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewRestaurantTextFieldCell.cellID, for: indexPath) as! NewRestaurantTextFieldCell
            cell.configure(with: "NAME", and: "Fill in the resaturant name")
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewRestaurantTextFieldCell.cellID, for: indexPath) as! NewRestaurantTextFieldCell
            cell.configure(with: "TYPE", and: "Fill in the resaturant type")
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewRestaurantTextFieldCell.cellID, for: indexPath) as! NewRestaurantTextFieldCell
            cell.configure(with: "ADDRESS", and: "Fill in the resaturant address")
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewRestaurantTextFieldCell.cellID, for: indexPath) as! NewRestaurantTextFieldCell
            cell.configure(with: "PHONE", and: "Fill in the resaturant phone")
            return cell
        }
        
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NewRestaurantTextViewCell.cellID, for: indexPath) as! NewRestaurantTextViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewRestaurantImagePickerCell.cellID, for: indexPath) as! NewRestaurantImagePickerCell
        return cell
    }
}
