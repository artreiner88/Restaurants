//
//  MapViewController.swift
//  Restaurants
//
//  Created by Artur Reiner on 05.06.24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var restaurant: Restaurant!
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setRestaurantDataOnMap()
    }
    
    private func setupLayout() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setRestaurantDataOnMap() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant.location) { [self] placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks[0]
            
            let annotation = MKPointAnnotation()
            annotation.title = restaurant.name
            annotation.subtitle = restaurant.type
            
            guard let location = placemark.location else { return }
            annotation.coordinate = location.coordinate
            
            mapView.showAnnotations([annotation], animated: true)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
