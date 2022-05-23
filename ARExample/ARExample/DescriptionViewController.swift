//
//  DescriptionViewController.swift
//  ARExample
//
//  Created by Fabian Ettinger on 23.05.22.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var model: Model? = nil;
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coordsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let current = model?.getCurrent(), let d = model?.descriptions {
            titleLabel.text = current.anchor;
            coordsLabel.text = "lat: \(current.lat), long: \(current.long)"
            for descr in d {
                if descr.forAnchor == current.anchor {
                    descriptionLabel.text = descr.text
                }
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
