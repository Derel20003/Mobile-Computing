//
//  NavigationController.swift
//  ARExample
//
//  Created by Dominik Auinger on 27.06.22.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func shouldAutoRotate() -> Bool {
        if (!viewControllers.isEmpty && topViewController?.isKind(of: MainViewController)) {
            return false;
        }
        return true;
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
