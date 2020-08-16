//
//  MGLLocationManager.swift
//  MapProject
//
//  Created by Anton Tolstov on 16.08.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Mapbox

extension MGLLocationManager {
    var locationAvailable: Bool {
        [CLAuthorizationStatus.authorizedWhenInUse, .authorizedAlways]
            .contains(authorizationStatus)
    }
}
