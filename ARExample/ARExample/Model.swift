//
//  Model.swift
//  ARExample
//
//  Created by Jana Ettinger on 23.04.22.
//

import Foundation
import RealityKit

class Model {
    var objects: [CustomGeoAnchor] = [];
    let path: String = "http://193.122.3.31/anchors"
    
    func addAnchor (toAdd anchor: CustomGeoAnchor) {
        objects.append(anchor)
    }
    
    func updateAnchors (_ lat: Double, _ long: Double) -> [String] {
        var anchors: [String] = []
        for anchor in objects {
            if let a = anchor.update(lat, long) {
                anchors.append(a)
            }
        }
        return anchors
    }
    
    func loadAnchors() {
        if let data = try? Data(contentsOf: URL(string: path)!) {
            if let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for anchor in obj {
                    addAnchor(toAdd: CustomGeoAnchor(anchor["type"] as! String, anchor["lat"] as! Double, anchor["long"]  as! Double))
                }
            }
        }
    }
    
}
