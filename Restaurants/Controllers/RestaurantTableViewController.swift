//
//  RestaurantTableViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 11.05.24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    private var restaurants = Restaurant.sampleData()
    private lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavbar()
        
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        setupLongPressGestureRecognizer()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureNavbar() {
        title = "Restaurants"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let appearance = navigationController?.navigationBar.standardAppearance else { return }
        appearance.configureWithTransparentBackground()
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureDataSource() -> RestaurantDiffableDataSource {
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.cellID)
        let dataSource = RestaurantDiffableDataSource(tableView: tableView) {
            tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.cellID, for: indexPath) as! RestaurantCell
            cell.set(restaurant: itemIdentifier)
            return cell
        }
        return dataSource
    }
    
    private func showOptionMenu(for indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let reserveActionHandler = { (action: UIAlertAction) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature not available yet", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true)
        }
        
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        
        
        let favoriteAction = UIAlertAction(
            title: restaurants[indexPath.row].isFavorite ? "Remove from favorites": "Mark as favorite",
            style: .default
        ) { _ in
            let cell = self.tableView.cellForRow(at: indexPath) as! RestaurantCell
            self.restaurants[indexPath.row].isFavorite.toggle()
            
            cell.favorite()
        }
        
        [cancelAction, reserveAction, favoriteAction].forEach(optionMenu.addAction(_:))
        present(optionMenu, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantDetailVC = RestaurantDetailViewController()
        restaurantDetailVC.restaurant = restaurants[indexPath.row]
        navigationController?.pushViewController(restaurantDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            completion(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { action, view, completion in
            let defaultText = "Just checking in at \(restaurant.name)"
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            self.present(activityController, animated: true)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = .systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }
}


extension RestaurantTableViewController: UIGestureRecognizerDelegate {
    
    private func setupLongPressGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        longPressGestureRecognizer.delaysTouchesBegan = true
        longPressGestureRecognizer.delegate = self
        
        tableView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc private func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else { return }
        guard gestureRecognizer.state == .began else { return }
        showOptionMenu(for: indexPath)
    }
}
