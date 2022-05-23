//
//  CustomGeoAnchor.swift
//  ARExample
//
//  Created by Jana Ettinger on 23.04.22.
//

import UIKit
import RealityKit

class CustomGeoAnchor {
    
    var lat = 0.0, long = 0.0;
    var anchor: String;
    var order = 0;
    
    init(_ anchor: String, _ lat: Double, _ long: Double, _ order: Int) {
        self.lat = round(Double(lat) * 10000) / 10000
        self.long = round(Double(long) * 10000) / 10000
        self.anchor = anchor
        self.order = order
    }
    
    func update(_ lat: Double, _ long: Double) -> String? {
        if (round(Double(lat) * 10000) / 10000 == self.lat && round(Double(long) * 10000) / 10000 == self.long) {
            return anchor
        }
        return nil
    }
    

}
