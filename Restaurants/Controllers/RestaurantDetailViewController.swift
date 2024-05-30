//
//  RestaurantDetailViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 26.05.24.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantDescriptionDataCell.self, forCellReuseIdentifier: RestaurantDescriptionDataCell.cellID)
        tableView.register(RestaurantContactsDataCell.self, forCellReuseIdentifier: RestaurantContactsDataCell.cellID)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var headerView: RestaurantDetailHeaderView = {
        let view = RestaurantDetailHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(with: restaurant)
        return view
    }()
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setupLayout()
    }
    
    private func setupLayout() {
        UITableView.appearance().sectionHeaderTopPadding = 0
        view.addSubview(tableView)
        tableView.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: tableView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}


extension RestaurantDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDescriptionDataCell.cellID, for: indexPath) as! RestaurantDescriptionDataCell
            cell.setDescription(text: restaurant.description)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantContactsDataCell.cellID, for: indexPath) as! RestaurantContactsDataCell
            cell.setData(address: restaurant.location, phone: restaurant.phone)
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
}
