//
//  CustomGeoAnchor.swift
//  ARExample
//
//  Created by Jana Ettinger on 23.04.22.
//

import UIKit
import ARKit

class CustomGeoAnchor {
    
    var lat = 0.0, long = 0.0;
    var anchor: ARAnchor;
    
    init(_ anchor: ARAnchor, _ lat: Double, _ long: Double) {
        self.lat = lat
        self.long = long
        self.anchor = anchor
    }
    
    func update(_ lat: Double, _ long: Double) -> ARAnchor? {
        if (lat == self.lat && long == self.long) {
            return anchor
        }
        return nil
    }
    

}
