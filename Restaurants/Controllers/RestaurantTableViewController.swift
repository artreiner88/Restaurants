//
//  RestaurantTableViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 11.05.24.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController {
    
    private var restaurants: [Restaurant] = []
    private lazy var dataSource = configureDataSource()
    private var fetchResultController: NSFetchedResultsController<Restaurant>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        configureTableView()
        setupLongPressGestureRecognizer()
        
        fetchRestaurantsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    private func configureTableView() {
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.dataSource = dataSource
    }
    
    private func configureNavbar() {
        title = "Restaurants"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        rightBarButton.tintColor = UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)
        navigationItem.rightBarButtonItem = rightBarButton
        
        guard let appearance = navigationController?.navigationBar.standardAppearance else { return }
        appearance.configureWithTransparentBackground()
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 218/255, green: 96/255, blue: 51/255, alpha: 1.0)]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func fetchRestaurantsData() {
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                updateSnapshot(animated: false)
            } catch {
                print(error)
            }
        }
    }
    
    private func deleteRestaurant(restaurant: Restaurant) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            
            // Delete the item
            context.delete(restaurant)
            appDelegate.saveContext()
        }
    }
    
    @objc private func addButtonTapped() {
        let nav = UINavigationController(rootViewController: NewRestaurantViewController())
        present(nav, animated: true)
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
    
    private func updateSnapshot(animated: Bool) {
        if let fetchedObjects = fetchResultController.fetchedObjects {
            restaurants = fetchedObjects
        }
        
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: animated)
        setNeedsUpdateContentUnavailableConfiguration()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if restaurants.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "storefront")
            config.text = "No Restaurants"
            config.secondaryText = "Add a new Restaurant"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
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
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                appDelegate.saveContext()
            }
        }
        
        [cancelAction, reserveAction, favoriteAction].forEach(optionMenu.addAction(_:))
        present(optionMenu, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantVC = RestaurantViewController()
        restaurantVC.restaurant = restaurants[indexPath.row]
        navigationController?.pushViewController(restaurantVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let restaurant = dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            self.deleteRestaurant(restaurant: restaurant)
            self.updateSnapshot(animated: true)
            self.setNeedsUpdateContentUnavailableConfiguration()
            completion(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { action, view, completion in
            let defaultText = "Just checking in at \(restaurant.name)"
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(data: restaurant.image) {
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


extension RestaurantTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        updateSnapshot(animated: true)
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
