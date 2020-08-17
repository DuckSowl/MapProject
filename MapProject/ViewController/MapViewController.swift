//
//  ViewController.swift
//  MapProject
//
//  Created by Anton Tolstov on 13.08.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Mapbox
import Pin

final class MapViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        // University of Greenwich
        static let defaultLocation = CLLocationCoordinate2D(latitude: 51.483,
                                                            longitude: 0)
        
        static let trackingButtonSide: CGFloat = 40
        static let layoutMargin: CGFloat = 8
    }
    
    // MARK: - Properties
    
    let mapView = MGLMapView()
    
    let userTrackingModeButton: UserTrackingModeButton = {
        let button = UserTrackingModeButton()
        button.addTarget(self, action: #selector(toggleUserTrackingMode),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = UIView()
        
        configureMapView()
        configureUserLocationTracking()
        configureUserTrackingModeButtonConstraints()
    }
    
    // MARK: - View Configuration
    
    private func configureMapView() {
        mapView.pin(super: view).all().activate
        mapView.compassViewMargins =
            .init(x: Constants.layoutMargin,
                  y: Constants.trackingButtonSide + Constants.layoutMargin)
        
        mapView.delegate = self
    }
    
    private func configureUserLocationTracking() {
        // Default location
        if !mapView.locationManager.locationAvailable {
            mapView.setCenter(Constants.defaultLocation,
                              zoomLevel: 13, animated: true)
        }
        
        mapView.locationManager.requestWhenInUseAuthorization()
        mapView.userTrackingMode = .follow
    }
    
    private func configureUserTrackingModeButtonConstraints() {
        userTrackingModeButton
            .pin(super: view)
            .size(Constants.trackingButtonSide)
            .topSafe().right(Constants.layoutMargin)
            .activate
    }
    
    // MARK: - Private Methods
    
    private func updateUserTrackingMode() {
        let locationAvailable = mapView.locationManager.locationAvailable
        let userTrackingMode = mapView.userTrackingMode
        userTrackingModeButton.update(with: locationAvailable ? userTrackingMode : nil)
    }
    
    // MARK: - Actions
    
    @objc private func toggleUserTrackingMode() {
        mapView.userTrackingMode =
            mapView.userTrackingMode == .follow ? .none : .follow
    }
}

// MARK: - MGLMapViewDelegate

extension MapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, didChange mode: MGLUserTrackingMode, animated: Bool) {
        updateUserTrackingMode()
    }

    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        updateUserTrackingMode()
    }
}
