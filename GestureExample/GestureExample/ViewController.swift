//
//  ViewController.swift
//  GestureExample
//
//  Created by Dominik Auinger on 01.02.22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cat: UIImageView!
    @IBOutlet weak var tuna: UIImageView!
    
    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        cat.center = CGPoint(
            x: cat.center.x + translation.x,
            y: cat.center.y + translation.y
        )

        if tuna.frame.intersects(cat.frame) {
            tuna.image = UIImage.init(named: "grete.jpeg")
        }
            
        sender.setTranslation(.zero, in: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

