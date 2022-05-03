//
//  ViewController.swift
//  ARExample
//
//  Created by Dominik Auinger on 28.03.22.
//

import UIKit
import RealityKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var arView: ARView!
    let model: Model = Model();
    var timer: Timer?;
    let locationManager = CLLocationManager()
    var shown: [String] = [];
    var newShown: [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        
        // Load the "Box" scene from the "Experience" Reality File
        //let boxAnchor = try! Experience.loadBox()
        //let a = try! Eingang.loadBox()
        //let b = try! Schilder.loadBox()
        
        model.addAnchor(toAdd: CustomGeoAnchor("Eingang", 48.2683, 14.2521))
        model.addAnchor(toAdd: CustomGeoAnchor("Schilder", 48.2682, 14.2523))
        
        //model.addAnchor(toAdd: )
        
        // Add the box anchor to the scene
        //arView.scene.anchors.append(boxAnchor)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let anchors = model.updateAnchors(location.latitude, location.longitude)
        arView.scene.anchors.removeAll()
        for anchor in anchors {
            newShown.append(anchor)
            if (!shown.contains(anchor)) {
                alert()
            
                var box: Scene.AnchorCollection.Element = try! Experience.loadBox();
                if (anchor == "Eingang") {
                    box = try! Eingang.loadBox()
                } else if (anchor == "Schilder") {
                    box = try! Eingang.loadBox()
                }
            
                arView.scene.anchors.append(box);
            }
        }
        shown.removeAll()
        shown.append(contentsOf: newShown)
        newShown.removeAll()
    }
    
    func alert () {
        
        let alert = UIAlertController(title: "Alert", message: "ARAnchor placed", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
