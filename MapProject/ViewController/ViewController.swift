//
//  ViewController.swift
//  MapProject
//
//  Created by Anton Tolstov on 13.08.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moscowLocation = CLLocationCoordinate2D(latitude: 55.7,
                                                    longitude: 37.6)
        let mapView = MGLMapView(frame: view.bounds)
        mapView.setCenter(moscowLocation, zoomLevel: 9, animated: false)
        view.addSubview(mapView)
    }


}
