//
//  RestaurantMapView.swift
//  Restaurants
//
//  Created by Artur Reiner on 11.06.24.
//

import UIKit
import MapKit

class RestaurantMapView: UIView {
    
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
        mapView.isScrollEnabled = false
        mapView.isRotateEnabled = false
        return mapView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configure(with location: String) {
        
        // Get location
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { [self] placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks[0]
            
            // Add annotaion
            let annotation = MKPointAnnotation()
            guard let location = placemark.location else { return }
            
            // Display the annotation
            annotation.coordinate = location.coordinate
            mapView.addAnnotation(annotation)
            
            // Set the zoom level
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
            mapView.setRegion(region, animated: true)
        }
    }
}
