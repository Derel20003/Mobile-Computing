//
//  MainViewController.swift
//  ARExample
//
//  Created by Dominik Auinger on 16.05.22.
//

import UIKit
import CoreLocation
import RealityKit

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var arView: ARView!
    @IBOutlet weak var distanceField: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    let model: Model = Model();
    var shown: [String] = [];
    var newShown: [String] = [];
    
    // temporary anchor-load, used for testing description and direction
    var testAnchor: CustomGeoAnchor = CustomGeoAnchor("Eingang", 48.2683, 14.2521)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.headingAvailable()) {
            self.locationManager.startUpdatingHeading()
            self.locationManager.startUpdatingLocation()
            self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        }
        
        model.loadAnchors()

    }
    
    // updates distance to next point and loads models
    func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        // loads distance from device to next point
        let distance = sqrt(pow(location.latitude-testAnchor.lat, 2)+pow(location.longitude-testAnchor.long, 2))
        var distanceText: String = ""
        
        // checks for "m" or "km" formatting
        if distance >= 0.1 {
            distanceText += "\(String((round(distance * 100) / 100) * 10))km"
        } else {
            distanceText = "\(String(Int((round(distance * 10000) / 10000) * 10000)))m"
        }
        distanceField.text = distanceText

        // loads anchors and places if near enough
        let anchors = model.updateAnchors(location.latitude, location.longitude)
        arView.scene.anchors.removeAll()
        for anchor in anchors {
            newShown.append(anchor)
            if (!shown.contains(anchor)) {
                alert()
            
                var box: Scene.AnchorCollection.Element = try! Experience.loadBox();
                if (anchor == "Eingang") {
                    box = try! Eingang.loadBox()
                    let newBox: Eingang.Box = try! box as! Eingang.Box;
                    newBox.actions.tapped.onAction = handleTapOnEntity(_:);
                } else if (anchor == "Schilder") {
                    box = try! Schilder.loadBox()
                    let newBox: Schilder.Box = try! box as! Schilder.Box;
                    newBox.actions.tapped.onAction = handleTapOnEntity(_:);
                }
                
                arView.scene.anchors.append(box)
            }
        }
        shown.removeAll()
        shown.append(contentsOf: newShown)
        newShown.removeAll()
        
    }
    
    func handleTapOnEntity (_ entity: Entity?) {
        guard let entity = entity else {
            return
        }
        
        let alert = UIAlertController(title: "Alert", message: "ARAnchor tapped", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // updates direction of arrow
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        // calculate right angle to point arrow, DOESN'T WORK
        
        //var dir = ((self.locationManager.heading?.magneticHeading.rounded())! as Double);
        let degreesToPoint = atan2(testAnchor.long-location.longitude, testAnchor.lat-location.latitude)*180/Double.pi

        arrow.transform = CGAffineTransform(rotationAngle: CGFloat(round(degreesToPoint)))

    }
    
    func alert () {
        let alert = UIAlertController(title: "Alert", message: "ARAnchor placed", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
