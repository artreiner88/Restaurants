//
//  RestaurantTableViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 11.05.24.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants = Restaurant.sampleData()
    
    enum Section {
        case all
    }
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: RestaurantCell.cellID)
        let dataSource = UITableViewDiffableDataSource<Section, Restaurant>(tableView: tableView) {
            tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCell.cellID, for: indexPath) as! RestaurantCell
            cell.set(restaurant: itemIdentifier)
            return cell
        }
        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantCell
            self.restaurants[indexPath.row].isFavorite.toggle()
            
            cell.favorite()
            
//            cell.favoriteImageView.isHidden = self.restaurants[indexPath.row].isFavorite
//            
//            self.restaurants[indexPath.row].isFavorite = self.restaurants[indexPath.row].isFavorite ? false : true
        }
        
        
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(reserveAction)
        optionMenu.addAction(favoriteAction)
        present(optionMenu, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
