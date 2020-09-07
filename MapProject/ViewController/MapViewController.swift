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
        static let maxDegreeSpanOffset = 0.1
        
        static let buttonHeight: CGFloat = 40
        static let layoutMargin: CGFloat = 8
        static let conrerRadius: CGFloat = 6
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
        
        configureLocationGenerationButton()
    }
    
    // MARK: - View Configuration
    
    private func configureMapView() {
        mapView.pin(super: view).all().activate
        mapView.logoViewPosition = .topLeft
        mapView.compassViewMargins =
            .init(x: Constants.layoutMargin,
                  y: Constants.buttonHeight + Constants.layoutMargin)
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
            .size(Constants.buttonHeight)
            .topSafe().right(Constants.layoutMargin)
            .activate
    }
    
    private func configureLocationGenerationButton() {
        let locationGenerationButton = UIButton()
        locationGenerationButton.backgroundColor = .systemGray6
        locationGenerationButton.layer.cornerRadius = Constants.conrerRadius
        
        locationGenerationButton.setTitle("Randomize Location", for: .normal)
        locationGenerationButton.setTitleColor(UIColor(light: .black, dark: .white),
                                               for: .normal)
        
        locationGenerationButton.addTarget(self, action: #selector(updateRandomLocation),
                                           for: .touchUpInside)
        
        let sideInsets = mapView.attributionButton.frame.width
            + mapView.attributionButtonMargins.x + Constants.layoutMargin
        locationGenerationButton.pin(super: view)
            .height(Constants.buttonHeight)
            .sides(sideInsets)
            .bottomSafe(Constants.layoutMargin)
            .activate
    }
    
    // MARK: - Private Methods
    
    private func updateUserTrackingMode() {
        let locationAvailable = mapView.locationManager.locationAvailable
        let userTrackingMode = mapView.userTrackingMode
        userTrackingModeButton.update(with: locationAvailable ? userTrackingMode : nil)
    }
    
    private func getAnnotation(coordinate: CLLocationCoordinate2D, image: UIImage) -> MGLPointAnnotation {
        
        let annotation = MGLPointAnnotation()
        annotation.coordinate = coordinate
        
        let shapeSource = MGLShapeSource(identifier: "marker-source", shape: annotation, options: nil)
        let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)
        
        mapView.style?.setImage(image, forName: "home-symbol")
        shapeLayer.iconImageName = NSExpression(forConstantValue: "home-symbol")
        
        mapView.style?.addSource(shapeSource)
        mapView.style?.addLayer(shapeLayer)
        
        return annotation
    }
    
    // MARK: - Actions
    
    @objc private func toggleUserTrackingMode() {
        mapView.userTrackingMode =
            mapView.userTrackingMode == .follow ? .none : .follow
    }
    
    @objc private func updateRandomLocation() {
        let newLocation = (mapView.userLocation?.coordinate ?? Constants.defaultLocation)
            .random(withinDegreeSpan: Constants.maxDegreeSpanOffset)
        
        print(newLocation.latitude, newLocation.longitude)
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
