//
//  Model.swift
//  ARExample
//
//  Created by Jana Ettinger on 23.04.22.
//

import Foundation
import ARKit

class Model {
    var objects: [CustomGeoAnchor] = [];
    
    func addAnchor (toAdd anchor: CustomGeoAnchor) {
        objects.append(anchor)
    }
    
    func updateAnchors (_ lat: Double, _ long: Double) -> [ARAnchor] {
        var anchors: [ARAnchor] = []
        for anchor in objects {
            if let a = anchor.update(lat, long) {
                anchors.append(a)
            }
        }
        return anchors
    }
    
}
