//
//  CLLocationCoordinate2D+.swift
//  MapProject
//
//  Created by Anton Tolstov on 07.09.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import CoreLocation

extension CLLocationCoordinate2D {
    func random(withinDegreeSpan maxOffset: CLLocationDegrees) -> CLLocationCoordinate2D {
        .init(latitude: (latitude + Double.random(in: -maxOffset...maxOffset)).modulus(90),
              longitude: longitude + Double.random(in: -maxOffset...maxOffset).modulus(180))
    }
}
