//
//  OverviewController.swift
//  ARExample
//
//  Created by Dominik Auinger on 28.03.22.
//

import UIKit

class OverviewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Show AR and Compass
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showARViewSegue" {
            _ = segue.destination as? ViewController
        } else if segue.identifier == "showCompassViewSegue" {
            _ = segue.destination as? CompassViewController
        } else if segue.identifier == "showLocationViewSegue" {
            _ = segue.destination as? LocationViewController
        }
    }

}
