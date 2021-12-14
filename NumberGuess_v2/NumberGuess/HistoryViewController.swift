//
//  HistoryViewController.swift
//  Test-Final
//
//  Created by Dominik Auinger on 06.12.21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var model: Model? = Model()
    
    @IBOutlet weak var textField: UILabel!
    
    override func viewDidLoad() {
        textField.text = "You needed \(model?.guessCount ?? 1) tries to guess correctly. Congrats!"
        super.viewDidLoad()
        model?.reset()
    }

}
