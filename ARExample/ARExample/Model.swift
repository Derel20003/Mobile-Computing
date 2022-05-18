//
//  Model.swift
//  ARExample
//
//  Created by Jana Ettinger on 23.04.22.
//

import Foundation
import RealityKit

public class Model {
    var objects: [CustomGeoAnchor] = [];
    var descriptions: [AnchorDescription] = [];
    let anchorPath: String = "http://193.122.3.31/anchors"
    let descriptionPath: String = "http://193.122.3.31/descriptions"
    // Temporary
    let models = ["Eingang": Eingang.self]
    
    func addAnchor (toAdd anchor: CustomGeoAnchor) {
        objects.append(anchor)
    }
    
    func addDescription (toAdd description: AnchorDescription) {
        descriptions.append(description)
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
    
    // get list of anchors
    func loadAnchors() {
        if let data = try? Data(contentsOf: URL(string: anchorPath)!) {
            if let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for anchor in obj {
                    addAnchor(toAdd: CustomGeoAnchor(anchor["type"] as! String, anchor["lat"] as! Double, anchor["long"]  as! Double))
                }
            }
        }
    }
    
    // get list of descriptions
    func loadDescriptions() {
        if let data = try? Data(contentsOf: URL(string: descriptionPath)!) {
            if let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                for description in obj {
                    addDescription(toAdd: AnchorDescription(description["for"] as! String, description["text"] as! String))
                }
            }
        }
    }
    
}
