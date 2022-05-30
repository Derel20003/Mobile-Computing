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
    @IBOutlet weak var nextButton: UIButton!
    
    
    let model: Model = Model();
    var shown = false;
    
    
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
        model.loadDescriptions()

    }
    
    // updates distance to next point and loads models
    func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let lat1 = location.latitude, lat2 = model.getCurrent()?.lat ?? 0, lon1 = location.longitude, lon2 = model.getCurrent()?.long ?? 0;
        
        let p = Double.pi / 180;
        let a = 0.5 - cos((lat2 - lat1) * p)/2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p))/2;
        
        // loads distance from device to next point
        let distance = 12742 * asin(sqrt(a))
        var distanceText: String = ""
        
        // checks for "m" or "km" formatting
        if distance >= 1.0 {
            distanceText += "\(String((round(distance * 10) / 10))) km"
        } else {
            distanceText = "\(String(Int(distance * 1000))) m"
        }
        distanceField.text = distanceText

        // loads anchors and places if near enough
        if !shown {
            let anchor = model.shouldPlaceAnchor(location.latitude, location.longitude)
            if anchor != nil{
                shown = true;
                alert()
            
                var box: Scene.AnchorCollection.Element = try! Experience.loadBox();
                if (anchor == "Eingang") {
                    box = try! Eingang.loadBox()
                    let newBox: Eingang.Box = box as! Eingang.Box;
                    newBox.actions.tapped.onAction = handleTapOnEntity(_:);
                } else if (anchor == "Schilder") {
                    box = try! Schilder.loadBox()
                    let newBox: Schilder.Box = box as! Schilder.Box;
                    newBox.actions.tapped.onAction = handleTapOnEntity(_:);
                }
                
                arView.scene.anchors.append(box)
                switchControls()
            }
        }
    }
    
    func switchControls() {
        if model.lastAnchorPlaced {
            nextButton.setTitle("Finish", for: .normal)
            self.performSegue(withIdentifier: "finished", sender: self)
        }
        nextButton.isHidden = !nextButton.isHidden
        distanceField.isHidden = !distanceField.isHidden
        arrow.isHidden = !arrow.isHidden
    }
    
    @IBAction func onNextTouchUpInside(_ sender: Any) {
        model.current += 1;
        self.shown = false;
        self.arView.scene.anchors.removeAll();
        switchControls()
    }
    
    func handleTapOnEntity (_ entity: Entity?) {
        guard entity != nil else {
            return
        }
        
        performSegue(withIdentifier: "showDescription", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finished" {
            _ = segue.destination as? FinalViewController;
        } else {
            let descrView = segue.destination as? DescriptionViewController;
            descrView?.model = model;
        }
    }
    
    // updates direction of arrow
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        // calculate right angle to point arrow, DOESN'T WORK
        
        let lat1 = location.latitude, lat2 = model.getCurrent()?.lat ?? 0, lon1 = location.longitude, lon2 = model.getCurrent()?.long ?? 0;
        
        var dir = ((self.locationManager.heading?.magneticHeading.rounded())! as Double);
        let dy = lat2-lat1;
        let dx = cos(Double.pi*180/lat1)*(lon2-lon1);
        let degreesToPoint = atan2(dy, dx);
        
        dir += degreesToPoint - 90;
        dir = dir.truncatingRemainder(dividingBy: 360);

        arrow.transform = CGAffineTransform(rotationAngle: CGFloat(-round(dir)*Double.pi/180))

    }
    
    func alert () {
        let alert = UIAlertController(title: "Found Anchor", message: "You have found the anchor", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Place", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
