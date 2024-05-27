//
//  RestaurantDiffableDataSource.swift
//  Restaurants
//
//  Created by Artur Reiner on 17.05.24.
//

import UIKit

enum Section {
    case all
}


class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}
